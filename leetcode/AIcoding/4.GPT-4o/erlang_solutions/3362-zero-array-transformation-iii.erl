-module(solution).
-export([can_transform/1]).

can_transform(List) ->
    TotalSum = lists:sum(List),
    if
        TotalSum rem 3 =:= 0 ->
            {ok, H} = lists:foldl(fun(X, {ok, Acc}) -> {ok, Acc + (X rem 3)} end, {ok, 0}, List),
            H rem 3 =:= 0;
        true ->
            false
    end.