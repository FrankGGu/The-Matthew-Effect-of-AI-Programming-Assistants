-module(solution).
-export([people_who_own_a_company/1]).

people_who_own_a_company(FavoriteCompanies) ->
    Lists = lists:map(fun(CompanyList) -> sets:from_list(CompanyList) end, FavoriteCompanies),
    People = lists:seq(0, length(FavoriteCompanies) - 1),
    [Person || Person <- People, is_not_subset(Person, Lists)].

is_not_subset(Index, Lists) ->
    List = lists:nth(Index + 1, Lists),
    lists:all(fun(OtherList) -> not sets:is_subset(List, OtherList) end, lists:delete(List, Lists)).