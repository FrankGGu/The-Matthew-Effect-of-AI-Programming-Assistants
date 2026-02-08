-spec check_if_exist(Arr :: [integer()]) -> boolean().
check_if_exist(Arr) ->
    Set = sets:from_list(Arr),
    lists:any(fun(X) -> 
        (X rem 2 == 0 andalso sets:is_element(X div 2, Set)) orelse
        sets:is_element(X * 2, Set)
    end, Arr).