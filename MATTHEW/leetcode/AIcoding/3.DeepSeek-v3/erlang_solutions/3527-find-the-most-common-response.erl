-module(solution).
-export([most_common_response/1]).

most_common_response(Responses) ->
    Counts = lists:foldl(fun(Response, Acc) ->
                            maps:update_with(Response, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, Responses),
    {MaxKey, _} = lists:foldl(fun({K, V}, {CurrentKey, CurrentMax}) ->
                                 if V > CurrentMax -> {K, V};
                                    true -> {CurrentKey, CurrentMax}
                                 end
                              end, {undefined, 0}, maps:to_list(Counts)),
    MaxKey.