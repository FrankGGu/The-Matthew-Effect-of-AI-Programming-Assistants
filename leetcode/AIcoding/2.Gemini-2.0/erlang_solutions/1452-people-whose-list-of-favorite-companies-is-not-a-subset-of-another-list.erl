-module(favorite_companies).
-export([people_whose_list_of_favorite_companies_is_not_a_subset_of_another_list/1]).

people_whose_list_of_favorite_companies_is_not_a_subset_of_another_list(FavoriteCompanies) ->
    Len = length(FavoriteCompanies),
    lists:filter(fun(I) ->
        not any(fun(J) ->
            I /= J andalso is_subset(lists:nth(I + 1, FavoriteCompanies), lists:nth(J + 1, FavoriteCompanies))
        end, lists:seq(0, Len - 1))
    end, lists:seq(0, Len - 1)).

is_subset(L1, L2) ->
    lists:all(fun(X) -> lists:member(X, L2) end, L1).