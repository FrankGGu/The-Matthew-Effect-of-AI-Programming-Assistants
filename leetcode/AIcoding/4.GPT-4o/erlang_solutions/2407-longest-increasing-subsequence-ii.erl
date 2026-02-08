-module(solution).
-export([length_of_lis/2]).

length_of_lis(N, nums) when N < 1 -> 0;
length_of_lis(N, nums) ->
    Sorted = lists:sort(nums),
    Longest = lists:foldl(fun(X, Acc) ->
        case lists:keyfind(X, 1, Acc) of
            false -> [{X, 1} | Acc];
            {X, Len} -> [{X, Len + 1} | lists:keydelete(X, 1, Acc)]
        end
    end, [], Sorted),
    lists:max([Len || {_, Len} <- Longest]).