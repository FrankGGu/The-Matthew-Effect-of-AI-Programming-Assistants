-spec pair_sum(Head :: #list_node{} | null) -> integer().
pair_sum(Head) ->
    List = to_list(Head),
    N = length(List),
    MaxSum = lists:max([lists:nth(I, List) + lists:nth(N - I + 1, List) || I <- lists:seq(1, N div 2)]),
    MaxSum.

to_list(null) -> [];
to_list(#list_node{val = Val, next = Next}) -> [Val | to_list(Next)].