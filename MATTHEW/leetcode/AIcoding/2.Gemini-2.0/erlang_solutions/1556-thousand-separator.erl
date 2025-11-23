-module(thousand_separator).
-export([thousand_separator/1]).

thousand_separator(N) ->
  thousand_separator(integer_to_list(N), []).

thousand_separator([], Acc) ->
  lists:reverse(Acc);
thousand_separator(Digits, Acc) ->
  {Chunk, Rest} = lists:split(3, lists:reverse(Digits)),
  case Acc of
    [] ->
      thousand_separator(lists:reverse(Rest), lists:reverse(Chunk));
    _ ->
      thousand_separator(lists:reverse(Rest), [$. | lists:reverse(Chunk)] ++ Acc)
  end.