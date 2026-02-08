-module(solution).
-export([min_impossible_or/1]).

-spec min_impossible_or(Nums :: [integer()]) -> integer().
min_impossible_or(Nums) ->
    SortedNums = lists:sort(Nums),

    FinalState = lists:foldl(
        fun(Num, {found, Answer}) ->
            {found, Answer};
        fun(Num, {not_found, ReachableORSum}) ->
            if Num > ReachableORSum + 1 ->
                {found, ReachableORSum + 1};
            true ->
                {not_found, ReachableORSum bor Num}
            end
        end,
        {not_found, 0},
        SortedNums
    ),

    case FinalState of
        {found, Answer} -> Answer;
        {not_found, ReachableORSum} -> ReachableORSum + 1
    end.