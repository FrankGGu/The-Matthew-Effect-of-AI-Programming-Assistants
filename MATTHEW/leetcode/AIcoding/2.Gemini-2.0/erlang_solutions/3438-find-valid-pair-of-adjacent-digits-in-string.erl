-module(find_valid_pair).
-export([solve/1]).

solve(S) ->
  solve(string:to_list(S), []).

solve([], Acc) ->
  lists:reverse(Acc);
solve([H1, H2 | T], Acc) ->
  D1 = H1 - $0,
  D2 = H2 - $0,
  case (D1 + D2) rem 2 == 0 and D1 =/= D2 of
    true -> solve([H2 | T], [D1 * 10 + D2 | Acc]);
    false -> solve([H2 | T], Acc)
  end;
solve([_], Acc) ->
  lists:reverse(Acc).