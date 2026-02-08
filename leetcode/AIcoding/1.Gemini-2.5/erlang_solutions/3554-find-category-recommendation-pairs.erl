-module(solution).
-export([find_category_recommendation_pairs/1]).

find_category_recommendation_pairs(Recommendations) ->
    UserCategories = lists:foldl(
        fun([UserID, CategoryID], Acc) ->
            maps:update_with(UserID, fun(L) -> [CategoryID | L] end, [CategoryID], Acc)
        end,
        #{},
        Recommendations
    ),

    AllPairs = lists:flatmap(
        fun({_UserID, Categories}) ->
            SortedCategories = lists:sort(Categories),
            generate_pairs(SortedCategories)
        end,
        maps:to_list(UserCategories)
    ),

    lists:sort(lists:usort(AllPairs)).

generate_pairs([]) -> [];
generate_pairs([_]) -> [];
generate_pairs([H|T]) ->
    lists:map(fun(X) -> [H, X] end, T) ++ generate_pairs(T).