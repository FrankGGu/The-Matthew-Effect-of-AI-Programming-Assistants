-module(solution).
-export([count_largest_group/1]).

sum_digits(0) -> 0;
sum_digits(N) -> (N rem 10) + sum_digits(N div 10).

build_sum_counts(Current, Max, AccMap) when Current =< Max ->
    Sum = sum_digits(Current),
    NewAccMap = maps:update_with(Sum, fun(Count) -> Count + 1 end, 1, AccMap),
    build_sum_counts(Current + 1, Max, NewAccMap);
build_sum_counts(_Current, _Max, AccMap) ->
    AccMap.

count_largest_group(N) ->
    SumCounts = build_sum_counts(1, N, #{}).

    Values = maps:values(SumCounts),
    case Values of
        [] -> 0;
        _ ->
            MaxCount = lists:max(Values),
            lists:foldl(fun(Count, Acc) ->
                            if Count == MaxCount -> Acc + 1;
                               true -> Acc
                            end
                        end, 0, Values)
    end.