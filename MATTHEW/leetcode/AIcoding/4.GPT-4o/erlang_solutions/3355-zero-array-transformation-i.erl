-module(solution).
-export([can_transform/1]).

can_transform(Arr) ->
    Total = lists:sum(Arr),
    Total rem 3 =:= 0 andalso lists:all(fun(X) -> X rem 3 =:= 0 end, Arr).