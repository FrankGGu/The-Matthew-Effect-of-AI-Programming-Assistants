-module(solution).
-export([count_winning_sequences/2]).

count_winning_sequences(N, K) ->
    Memo = dict:new(),
    count_winning_sequences_helper(N, K, [], Memo).

count_winning_sequences_helper(0, _, _, _) ->
    1;
count_winning_sequences(_, 0, _, _) ->
    0;
count_winning_sequences(N, K, Used, Memo) ->
    case dict:find({N, K, Used}, Memo) of
        {ok, Count} ->
            Count;
        error ->
            Count = lists:foldl(
                      fun(Num, Acc) ->
                          case lists:member(Num, Used) of
                              true ->
                                  Acc;
                              false ->
                                  Acc + count_winning_sequences_helper(N - 1, K - 1, [Num | Used], Memo)
                          end
                      end,
                      0,
                      lists:seq(1, N)
                  ),
            dict:store({N, K, Used}, Count, Memo),
            Count
    end.