-module(solution).
-export([find_maximum_elegance/2]).

find_maximum_elegance(Items, K) ->
    {Unique, Duplicates} = lists:partition(fun({_, C}) -> C =:= 1 end, Items),
    Sorted = lists:sort(fun({P1, _}, {P2, _}) -> P1 > P2 end, Items),
    {Selected, Rest} = lists:split(K, Sorted),
    UniqueSelected = lists:filter(fun({_, C}) -> C =:= 1 end, Selected),
    Profit = lists:sum([P || {P, _} <- Selected]),
    Distinct = length(lists:usort([C || {_, C} <- Selected])),
    MaxElegance = Profit + Distinct * Distinct,
    case length(UniqueSelected) =:= 0 of
        true -> MaxElegance;
        false ->
            {MinUniqueProfit, MinUniqueCategory} = lists:min([{P, C} || {P, C} <- UniqueSelected]),
            PotentialReplacements = lists:filter(fun({P, C}) -> 
                not lists:member(C, [Cat || {_, Cat} <- Selected]) andalso C =/= MinUniqueCategory
            end, Rest),
            case PotentialReplacements of
                [] -> MaxElegance;
                _ ->
                    {MaxP, MaxC} = lists:max([{P, C} || {P, C} <- PotentialReplacements]),
                    NewProfit = Profit - MinUniqueProfit + MaxP,
                    NewDistinct = Distinct + 1,
                    NewElegance = NewProfit + NewDistinct * NewDistinct,
                    max(MaxElegance, NewElegance)
            end
    end.