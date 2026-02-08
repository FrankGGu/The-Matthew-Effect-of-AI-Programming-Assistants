-module(solution).
-export([numRestrictedRequests/2]).

numRestrictedRequests(Friends, requests) ->
    FriendsList = lists:map(fun(X) -> X - 1 end, Friends),
    Requests = lists:foldl(fun({A, B}, Acc) ->
        if
            A > B andalso lists:nth(A + 1, FriendsList) >= B andalso lists:nth(B + 1, FriendsList) >= A ->
                Acc + 1;
            true ->
                Acc
        end
    end, 0, requests),
    Requests.