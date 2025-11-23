-module(solution).
-export([max_profit_assignment/3]).

-spec max_profit_assignment(Difficulty :: [integer()], Profit :: [integer()], Worker :: [integer()]) -> integer().
max_profit_assignment(Difficulty, Profit, Worker) ->
    Jobs = lists:zip(Difficulty, Profit),
    SortedJobs = lists:keysort(1, Jobs),
    SortedWorkers = lists:sort(Worker),
    {Total, _, _} = lists:foldl(
        fun(W, {Sum, Best, Index}) ->
            {NewBest, NewIndex} = find_max_profit(W, SortedJobs, Best, Index),
            {Sum + NewBest, NewBest, NewIndex}
        end,
        {0, 0, 0},
        SortedWorkers
    ),
    Total.

find_max_profit(W, Jobs, Best, Index) ->
    find_max_profit(W, Jobs, Best, Index, length(Jobs)).

find_max_profit(W, Jobs, Best, Index, Length) when Index < Length ->
    {D, P} = lists:nth(Index + 1, Jobs),
    if
        W >= D -> find_max_profit(W, Jobs, max(Best, P), Index + 1, Length);
        true -> {Best, Index}
    end;
find_max_profit(_, _, Best, Index, _) -> {Best, Index}.