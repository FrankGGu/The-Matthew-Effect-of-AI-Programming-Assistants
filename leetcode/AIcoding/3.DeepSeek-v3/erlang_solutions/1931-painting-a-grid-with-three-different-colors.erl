-module(solution).
-export([color_the_grid/2]).

-spec color_the_grid(M :: integer(), N :: integer()) -> integer().
color_the_grid(M, N) ->
    Mod = 1000000007,
    Colors = 3,
    Total = trunc(math:pow(Colors, M)),
    DP = maps:new(),
    DP1 = init_dp(M, Total, DP),
    DP2 = solve(N, M, Total, DP1, Mod),
    sum_values(DP2, Mod).

init_dp(M, Total, DP) ->
    lists:foldl(fun(Mask, Acc) ->
        case is_valid(Mask, M) of
            true -> maps:put(Mask, 1, Acc);
            false -> Acc
        end
    end, DP, lists:seq(0, Total - 1)).

is_valid(Mask, M) ->
    is_valid(Mask, M, -1, 0).

is_valid(_Mask, 0, _Prev, _Pos) -> true;
is_valid(Mask, M, Prev, Pos) ->
    Current = (Mask bsr (2 * Pos)) band 3,
    if
        Current == Prev -> false;
        true -> is_valid(Mask, M - 1, Current, Pos + 1)
    end.

solve(1, _M, _Total, DP, _Mod) -> DP;
solve(N, M, Total, DP, Mod) ->
    NewDP = maps:new(),
    UpdatedDP = lists:foldl(fun(Mask1, Acc) ->
        case maps:get(Mask1, DP, 0) of
            0 -> Acc;
            Count1 ->
                lists:foldl(fun(Mask2, InnerAcc) ->
                    case is_compatible(Mask1, Mask2, M) of
                        true ->
                            Current = maps:get(Mask2, InnerAcc, 0),
                            NewCount = (Current + Count1) rem Mod,
                            maps:put(Mask2, NewCount, InnerAcc);
                        false -> InnerAcc
                    end
                end, Acc, lists:seq(0, Total - 1))
        end
    end, NewDP, lists:seq(0, Total - 1)),
    solve(N - 1, M, Total, UpdatedDP, Mod).

is_compatible(Mask1, Mask2, M) ->
    is_compatible(Mask1, Mask2, M, 0).

is_compatible(_Mask1, _Mask2, 0, _Pos) -> true;
is_compatible(Mask1, Mask2, M, Pos) ->
    Color1 = (Mask1 bsr (2 * Pos)) band 3,
    Color2 = (Mask2 bsr (2 * Pos)) band 3,
    if
        Color1 == Color2 -> false;
        true -> is_compatible(Mask1, Mask2, M - 1, Pos + 1)
    end.

sum_values(DP, Mod) ->
    lists:foldl(fun({_K, V}, Acc) -> (Acc + V) rem Mod end, 0, maps:to_list(DP)).