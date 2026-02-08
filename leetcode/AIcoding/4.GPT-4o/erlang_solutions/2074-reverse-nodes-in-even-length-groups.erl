-module(solution).
-export([reverse_even_length_groups/1]).

-record(node, {val, next}).

reverse_even_length_groups(List) ->
    GroupSizes = get_group_sizes(length(List)),
    Groups = split_into_groups(List, GroupSizes, [], []),
    ReversedGroups = lists:map(fun(Group) -> reverse_group(Group) end, Groups),
    merge_groups(ReversedGroups).

get_group_sizes(N) ->
    get_sizes(N, 1, 1).

get_sizes(0, _, _) -> [];
get_sizes(N, Size, Count) when Size rem 2 == 0 -> 
    [Size | get_sizes(N - Size, Size + 1, Count + 1)];
get_sizes(N, Size, Count) -> 
    get_sizes(N, Size + 1, Count).

split_into_groups([], [], Acc, Groups) -> 
    lists:reverse([lists:reverse(Acc) | Groups]);
split_into_groups([], [_ | Rest], Acc, Groups) -> 
    split_into_groups([], Rest, Acc, Groups);
split_into_groups([H | T], [Size | Rest], Acc, Groups) -> 
    split_into_groups(T, Rest, [H | Acc], Groups).

reverse_group(Group) -> 
    lists:reverse(Group).

merge_groups([]) -> [];
merge_groups([H | T]) -> 
    H ++ merge_groups(T).

reverse(List) -> 
    lists:reverse(List).