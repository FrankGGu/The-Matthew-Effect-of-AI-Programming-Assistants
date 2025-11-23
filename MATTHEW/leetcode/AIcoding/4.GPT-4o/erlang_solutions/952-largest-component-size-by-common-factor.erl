-module(solution).
-export([largest_component_size/1]).

largest_component_size(Numbers) ->
    Max = lists:max(Numbers),
    Factors = lists:foldl(fun(X, Acc) -> Acc ++ get_factors(X) end, [], Numbers),
    UniqueFactors = lists:usort(Factors),
    FactorGroups = lists:foldl(fun(Factor, Acc) -> [{Factor, []} | Acc] end, [], UniqueFactors),
    Grouped = group_numbers(Numbers, FactorGroups),
    lists:max(lists:map(fun({_, Group}) -> length(Group) end, Grouped)).

get_factors(N) ->
    lists:filter(fun(X) -> N rem X == 0 end, lists:seq(1, trunc(math:sqrt(N)))).

group_numbers([], Groups) -> Groups;
group_numbers([H | T], Groups) ->
    NewGroups = lists:foldl(fun({Factor, Group}, Acc) ->
        if H rem Factor == 0 -> [{Factor, [H | Group]} | Acc];
           true -> [{Factor, Group} | Acc]
        end
    end, [], Groups),
    group_numbers(T, NewGroups).