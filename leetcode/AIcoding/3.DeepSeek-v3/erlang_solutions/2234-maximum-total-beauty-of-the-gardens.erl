-module(solution).
-export([maximum_beauty/2]).

-spec maximum_beauty(Flowers :: [integer()], NewFlowers :: integer()) -> integer().
maximum_beauty(Flowers, NewFlowers) ->
    Sorted = lists:sort(Flowers),
    N = length(Sorted),
    Prefix = prefix_sum(Sorted),
    Ans = 0,
    {Ans, _} = lists:foldl(fun(I, {Max, K}) ->
        Min = lists:nth(I, Sorted),
        Total = (I - 1) * Min - lists:nth(I - 1, Prefix),
        case Total > NewFlowers of
            true -> {Max, K};
            false ->
                Left = NewFlowers - Total,
                Low = Min,
                High = lists:nth(N, Sorted) + Left div (N - I + 1) + 1,
                Full = find_max_full(Sorted, Prefix, I, N, Left, Low, High),
                {erlang:max(Max, (I - 1) * (I - 1) + Full * Full), I}
        end
    end, {Ans, 0}, lists:seq(1, N + 1)),
    Ans.

prefix_sum(List) ->
    lists:foldl(fun(X, [H|T]) -> [H + X | [H|T]] end, [0], List).

find_max_full(Sorted, Prefix, I, N, Left, Low, High) ->
    case Low < High of
        false -> Low - 1;
        true ->
            Mid = (Low + High) div 2,
            Total = (Mid * (N - I + 1)) - (lists:nth(N, Prefix) - lists:nth(I - 1, Prefix)),
            case Total > Left of
                true -> find_max_full(Sorted, Prefix, I, N, Left, Low, Mid);
                false -> find_max_full(Sorted, Prefix, I, N, Left, Mid + 1, High)
            end
    end.