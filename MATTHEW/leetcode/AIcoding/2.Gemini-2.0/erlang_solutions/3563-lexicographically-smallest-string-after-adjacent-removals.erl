-module(smallest_string).
-export([lexicographically_smallest_string/1]).

lexicographically_smallest_string(S) ->
  Stack = stack_string(S, []),
  list_to_binary(lists:reverse(Stack)).

stack_string(<<>>, Stack) ->
  Stack;
stack_string(<<Char, Rest/binary>>, Stack) ->
  case Stack of
    [] ->
      stack_string(Rest, [Char]);
    [Top | Tail] ->
      if
        Char < Top ->
          stack_string(Rest, Tail);
        true ->
          stack_string(Rest, [Char | Stack])
      end
  end.