-module(most_common_response).
-export([solve/1]).

solve(Responses) ->
    lists:foldl(fun(Response, Acc) ->
                        case maps:is_key(Response, Acc) of
                            true ->
                                maps:update(Response, maps:get(Response, Acc) + 1, Acc);
                            false ->
                                maps:put(Response, 1, Acc)
                        end
                    end, #{}, Responses)
    |> maps:to_list()
    |> lists:keysort(2)
    |> lists:last()
    |> element(1).