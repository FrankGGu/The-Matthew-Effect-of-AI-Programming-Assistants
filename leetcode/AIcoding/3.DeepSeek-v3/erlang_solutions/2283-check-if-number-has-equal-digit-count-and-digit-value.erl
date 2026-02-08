-spec digit_count(Num :: unicode:unicode_binary()) -> boolean().
digit_count(Num) ->
    List = [C - $0 || C <- unicode:characters_to_list(Num)],
    Counts = lists:foldl(fun(X, Acc) -> 
                            maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) 
                         end, #{}, List),
    lists:all(fun({I, C}) -> 
                 case maps:get(I, Counts, 0) of
                     C -> true;
                     _ -> false
                 end
              end, lists:zip(lists:seq(0, length(List) - 1), List)).