-module(solution).
-export([count_zero_request_servers/2]).

count_zero_request_servers(N, Requests) ->
    count_zero_requests(N, Requests, 0).

count_zero_requests(0, _, Count) -> Count;
count_zero_requests(N, Requests, Count) ->
    case lists:nth(N, Requests) of
        0 -> count_zero_requests(N - 1, Requests, Count + 1);
        _ -> count_zero_requests(N - 1, Requests, Count)
    end.