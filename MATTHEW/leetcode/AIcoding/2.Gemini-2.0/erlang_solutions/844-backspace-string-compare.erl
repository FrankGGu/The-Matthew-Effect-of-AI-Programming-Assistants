-module(backspace_string_compare).
-export([backspace_compare/2]).

backspace_compare(S, T) ->
  process_string(S) == process_string(T).

process_string(Str) ->
  process_string(Str, []).

process_string([], Acc) ->
  lists:reverse(Acc);
process_string([Char | Rest], Acc) ->
  if
    Char == $\# ->
      case Acc of
        [] ->
          process_string(Rest, []);
        [_ | Tail] ->
          process_string(Rest, Tail)
      end;
    true ->
      process_string(Rest, [Char | Acc])
  end.