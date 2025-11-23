-module(solution).
-export([most_common_response/1]).

most_common_response(Responses) ->
    lists:foldl(fun(Response, Acc) ->
        case lists:keyfind(Response, 1, Acc) of
            {Response, Count} -> 
                lists:keyreplace(Response, 1, Acc, {Response, Count + 1});
            false -> 
                [{Response, 1} | Acc]
        end
    end, [], Responses).