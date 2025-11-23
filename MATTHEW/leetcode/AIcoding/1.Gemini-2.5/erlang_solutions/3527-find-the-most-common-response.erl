-module(solution).
-export([most_common_response/1]).

most_common_response(Responses) ->
    FreqMap = lists:foldl(fun(Response, AccMap) ->
                                  maps:update_with(Response, fun(Count) -> Count + 1 end, 1, AccMap)
                          end, #{}, Responses),

    {MostCommonResponse, _} = maps:fold(fun(Response, Count, {CurrentMaxResponse, CurrentMaxCount}) ->
                                                if Count > CurrentMaxCount ->
                                                       {Response, Count};
                                                   true ->
                                                       {CurrentMaxResponse, CurrentMaxCount}
                                                end
                                        end, {undefined, -1}, FreqMap),
    MostCommonResponse.