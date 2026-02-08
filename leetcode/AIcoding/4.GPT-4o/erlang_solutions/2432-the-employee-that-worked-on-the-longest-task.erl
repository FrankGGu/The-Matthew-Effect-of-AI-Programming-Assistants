-module(solution).
-export([topEmployee/2]).

topEmployee/2 (logs, k) ->
    logs
    |> lists:foldl(fun({Id, Time}, Acc) ->
        case maps:is_key(Id, Acc) of
            true -> maps:update(Id, fun(X) -> X + Time end, Acc);
            false -> maps:put(Id, Time, Acc)
        end
    end, maps:new())
    |> maps:to_list()
    |> lists:sort(fun({_, A}, {_, B}) -> A > B end)
    |> lists:map(fun({Id, _}) -> Id end)
    |> lists:sublist(1, k).