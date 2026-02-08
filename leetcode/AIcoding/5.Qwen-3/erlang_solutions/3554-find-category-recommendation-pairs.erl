-module(solution).
-export([find_category_recommendation_pairs/1]).

find_category_recommendation_pairs(Items) ->
    Map = maps:from_list([{Id, Category} || {Id, Category} <- Items]),
    Categories = lists:usort([Category || {_, Category} <- Items]),
    Results = lists:foldl(fun(Category, Acc) ->
        Users = [Id || {Id, C} <- Items, C == Category],
        Pairs = lists:foldr(fun(U1, Acc2) ->
            lists:foldr(fun(U2, Acc3) ->
                if U1 < U2 -> [{U1, U2} | Acc3];
                   true -> Acc3
                end
            end, Acc2, Users)
        end, [], Users),
        lists:foldl(fun({U1, U2}, Acc3) ->
            case maps:is_key(U1, Map) andalso maps:is_key(U2, Map) of
                true -> [{U1, U2} | Acc3];
                false -> Acc3
            end
        end, Acc, Pairs)
    end, [], Categories),
    lists:sort(Results).