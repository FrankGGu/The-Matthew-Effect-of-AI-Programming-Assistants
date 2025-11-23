-module(solution).
-export([find_number_of_lis/1]).

find_number_of_lis(Nums) ->
    Length = length(Nums),
    {Lengths, Counts} = lists:foldl(fun(X, {Lengths, Counts}) ->
        NewLengths = lists:map(fun({Length, Count}) ->
            if
                X > Length -> {Length + 1, Count};
                X =< Length -> {1, Count}
            end
        end, lists:zip(Lengths, Counts)),
        NewCounts = lists:map(fun({{Length, _}, Count}) ->
            {Length, lists:sum([C || {L, C} <- lists:zip(Lengths, Counts), L =:= Length])}
        end, lists:zip(NewLengths, Counts)),
        NewLengths1 = [max(1, {Length, Count}) || {Length, Count} <- NewLengths],
        {NewLengths1, NewCounts}
    end, {lists:map(fun(_) -> 1 end, Nums), lists:map(fun(_) -> 1 end, Nums)}, Nums),
    MaxLength = lists:max(Lengths),
    lists:sum([Count || {Length, Count} <- lists:zip(Lengths, Counts), Length =:= MaxLength]).