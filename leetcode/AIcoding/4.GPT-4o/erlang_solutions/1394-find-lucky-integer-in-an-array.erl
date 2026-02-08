-module(lucky_integer).
-export([find_lucky/1]).

find_lucky(List) ->
    Luckys = lists:filter(fun(X) -> X == lists:count(List, X) end, List),
    case Luckys of
        [] -> -1;
        _ -> lists:max(Luckys)
    end.