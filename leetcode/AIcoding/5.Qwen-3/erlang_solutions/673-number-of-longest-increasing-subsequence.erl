-module(solution).
-export([length_of_lis/1]).

length_of_lis(Nums) ->
    {_, Count} = lists:foldl(fun(N, {Lis, Count}) ->
        {NewLis, NewCount} = find_max_length_and_count(Nums, N),
        {lists:max([Lis, NewLis]), Count + NewCount}
    end, {0, 0}, Nums),
    Count.

find_max_length_and_count(Nums, N) ->
    lists:foldl(fun({I, Val}, {MaxLen, TotalCount}) ->
        if
            Val < N ->
                {Len, Count} = get_length_and_count(Nums, I),
                if
                    Len + 1 > MaxLen ->
                        {Len + 1, Count};
                    Len + 1 == MaxLen ->
                        {Len + 1, TotalCount + Count};
                    true ->
                        {MaxLen, TotalCount}
                end;
            true ->
                {MaxLen, TotalCount}
        end
    end, {1, 1}, lists:zip(lists:seq(0, length(Nums) - 1), Nums)).

get_length_and_count(Nums, Index) ->
    lists:keyfind(Index, 1, lists:zip(lists:seq(0, length(Nums) - 1), [0 || _ <- Nums])).