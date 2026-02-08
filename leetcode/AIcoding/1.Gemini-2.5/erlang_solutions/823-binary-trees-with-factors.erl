-module(solution).
-export([numFactoredBinaryTrees/1]).

numFactoredBinaryTrees(Arr) ->
    MOD = 1000000007,
    SortedArr = lists:sort(Arr),
    N = length(SortedArr),

    InitialDP = maps:from_list([{X, 1} || X <- SortedArr]),

    DP = calculate_dp(0, SortedArr, InitialDP, N, MOD),

    lists:foldl(fun({_Key, Value}, Sum) ->
        (Sum + Value) rem MOD
    end, 0, maps:to_list(DP)).

calculate_dp(Index, SortedArr, CurrentDP, N, MOD) when Index < N ->
    Root = lists:nth(Index + 1, SortedArr),

    RootCount = maps:get(Root, CurrentDP),
    NewRootCount = lists:foldl(fun(LeftIndex, AccCount) ->
        Left = lists:nth(LeftIndex + 1, SortedArr),

        case Root rem Left of
            0 ->
                Right = Root div Left,
                case maps:find(Right, CurrentDP) of
                    {ok, CountRight} ->
                        CountLeft = maps:get(Left, CurrentDP),
                        (AccCount + (CountLeft * CountRight) rem MOD) rem MOD;
                    _ ->
                        AccCount
                end;
            _ ->
                AccCount
        end
    end, RootCount, lists:seq(0, Index - 1)),

    UpdatedDP = maps:put(Root, NewRootCount, CurrentDP),
    calculate_dp(Index + 1, SortedArr, UpdatedDP, N, MOD);
calculate_dp(_Index, _SortedArr, CurrentDP, _N, _MOD) ->
    CurrentDP.