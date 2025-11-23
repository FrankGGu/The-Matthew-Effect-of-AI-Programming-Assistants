-module(solution).
-export([check_if_exist/1]).

check_if_exist(List) ->
    Sets = sets:from_list(List),
    lists:any(fun(X) -> sets:is_element(X * 2, Sets) orelse sets:is_element(X / 2, Sets) end, List).