-module(apply_operations).
-export([min_operations/3]).

min_operations(S1, S2, X) ->
    S1_list = string:to_list(S1),
    S2_list = string:to_list(S2),
    Diffs = lists:zipwith(fun(A, B) -> if A /= B -> 1; true -> 0 end, S1_list, S2_list),
    Changes = lists:sum(Diffs),

    case Changes of
        0 -> 0;
        _ ->
            solve(Diffs, X)
    end.

solve(Diffs, X) ->
    N = length(Diffs),
    DP = array:new([N + 1], {default, infinity}),
    array:set(0, 0, DP),

    lists:foreach(fun(I) ->
                      Val = array:get(I - 1, DP),
                      case lists:nth(I, Diffs) of
                          1 ->
                              array:set(I, Val + 1, DP);
                          _ ->
                              array:set(I, Val, DP)
                      end,

                      if I > 1 andalso lists:nth(I, Diffs) == 1 andalso lists:nth(I - 1, Diffs) == 1 ->
                          PrevVal = array:get(I - 2, DP),
                          NewVal = PrevVal + min(2, X);
                          CurrentVal = array:get(I, DP),
                          array:set(I, min(CurrentVal, NewVal), DP)
                      end
                  end, lists:seq(1, N)),

    array:get(N, DP).

infinity() -> 1000000007.