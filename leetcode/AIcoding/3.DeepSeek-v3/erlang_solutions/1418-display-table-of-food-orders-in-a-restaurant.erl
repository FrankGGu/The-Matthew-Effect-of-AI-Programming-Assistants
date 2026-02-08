-spec display_table(Orders :: [[unicode:unicode_binary()]]) -> [[unicode:unicode_binary()]].
display_table(Orders) ->
    FoodSet = sets:from_list([Food || [_, _, Food] <- Orders]),
    Foods = lists:sort(sets:to_list(FoodSet)),
    TableMap = lists:foldl(fun([_, Table, Food], Acc) ->
                                  TableBin = list_to_binary(Table),
                                  case maps:find(TableBin, Acc) of
                                      {ok, CountMap} ->
                                          NewCount = maps:get(Food, CountMap, 0) + 1,
                                          NewCountMap = maps:put(Food, NewCount, CountMap),
                                          maps:put(TableBin, NewCountMap, Acc);
                                      error ->
                                          CountMap = maps:put(Food, 1, #{}),
                                          maps:put(TableBin, CountMap, Acc)
                                  end
                          end, #{}, Orders),
    Tables = lists:sort(fun(A, B) ->
                                binary_to_integer(A) < binary_to_integer(B)
                        end, maps:keys(TableMap)),
    Header = [<<"Table">> | Foods],
    Rows = lists:map(fun(Table) ->
                             CountMap = maps:get(Table, TableMap),
                             Counts = [integer_to_binary(maps:get(Food, CountMap, 0)) || Food <- Foods],
                             [Table | Counts]
                     end, Tables),
    [Header | Rows].