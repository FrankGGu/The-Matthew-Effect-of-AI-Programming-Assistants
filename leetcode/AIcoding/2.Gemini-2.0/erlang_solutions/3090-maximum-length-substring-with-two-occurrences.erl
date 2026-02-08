-module(max_length_substring).
-export([solve/1]).

solve(S) ->
  solve(S, 0, 0).

solve(S, MaxLen, Start) ->
  Len = length(S),
  if Start >= Len then
    MaxLen
  else
    solve(S, solve_helper(S, Start, Len, MaxLen), Start + 1)
  end.

solve_helper(S, Start, Len, MaxLen) ->
  lists:foldl(fun(End, Acc) ->
                  Sub = lists:sublist(S, Start + 1, End - Start),
                  case string:str(S, Sub) of
                    0 ->
                      Acc;
                    _ ->
                      case string:str(string:substr(S, string:str(S, Sub) + length(Sub)), Sub) of
                        0 ->
                          Acc;
                        _ ->
                          NewLen = length(Sub),
                          max(Acc, NewLen)
                      end
                  end
              end, MaxLen, lists:seq(Start + 1, Len)).