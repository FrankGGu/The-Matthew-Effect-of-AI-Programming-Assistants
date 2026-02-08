-spec replace_elements(Arr :: [integer()]) -> [integer()].
replace_elements(Arr) ->
    replace_elements(Arr, -1, []).

replace_elements([], _, Acc) ->
    lists:reverse(Acc);
replace_elements([H | T], Max, Acc) ->
    replace_elements(T, max(H, Max), [Max | Acc]).