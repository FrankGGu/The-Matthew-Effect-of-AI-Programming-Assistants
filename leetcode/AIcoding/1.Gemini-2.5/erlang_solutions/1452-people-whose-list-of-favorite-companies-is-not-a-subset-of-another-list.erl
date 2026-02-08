-module(solution).
-export([favorite_companies_not_subset_of_another_list/1]).

favorite_companies_not_subset_of_another_list(FavoriteCompanies) ->
    IndexedSets = lists:map(fun({Companies, Index}) -> {Index, gb_sets:from_list(Companies)} end,
                            lists:zip(FavoriteCompanies, lists:seq(0, length(FavoriteCompanies) - 1))),

    lists:filtermap(fun({Index_i, Set_i}) ->
                        IsSubsetOfAnother = lists:any(fun({Index_j, Set_j}) ->
                                                          Index_i =/= Index_j andalso gb_sets:is_subset(Set_i, Set_j)
                                                      end, IndexedSets),
                        if IsSubsetOfAnother -> false;
                           true -> {true, Index_i}
                        end
                    end, IndexedSets).