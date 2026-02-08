-module(count_zero_request_servers).
-export([count_servers/2]).

count_servers(N, Logs) ->
  count_servers_helper(N, Logs, []).

count_servers_helper(N, Logs, Acc) ->
  case Logs of
    [] ->
      lists:reverse(Acc);
    [Log | Rest] ->
      ServerCounts = lists:foldl(fun({Timestamp, ServerId}, ServerCountsAcc) ->
                                      case maps:is_key(ServerId, ServerCountsAcc) of
                                        true ->
                                          maps:update(ServerId, maps:get(ServerId, ServerCountsAcc) + 1, ServerCountsAcc);
                                        false ->
                                          maps:put(ServerId, 1, ServerCountsAcc)
                                      end
                                  end, #{}, Logs),
      ZeroCount = lists:foldl(fun(ServerId, Count) ->
                                  case maps:is_key(ServerId, ServerCounts) of
                                    true ->
                                      case maps:get(ServerId, ServerCounts) of
                                        0 -> Count + 1;
                                        _ -> Count
                                      end;
                                    false ->
                                      Count + 1
                                  end
                              end, 0, lists:seq(1, N)),
      count_servers_helper(N, Rest, [ZeroCount | Acc])
  end.