-module(largest_sum_of_averages).
-export([largest_sum_of_averages/2]).

largest_sum_of_averages(A, K) ->
    N = length(A),
    Memo = dict:new(),
    largest_sum_of_averages_helper(A, 0, K, N, Memo).

largest_sum_of_averages_helper(A, Start, K, N, Memo) ->
    case dict:find({Start, K}, Memo) of
        {ok, Result} ->
            Result;
        error ->
            Result =
                if K =:= 1 ->
                    lists:sum(lists:sublist(A, Start+1, N-Start)) / (N - Start);
                true ->
                    lists:foldl(
                        fun(I, MaxSoFar) ->
                            Avg = lists:sum(lists:sublist(A, Start+1, I-Start)) / (I - Start),
                            NewMax = Avg + largest_sum_of_averages_helper(A, Start + I - Start, K - 1, N, Memo),
                            max(MaxSoFar, NewMax)
                        end,
                        -1.0,
                        lists:seq(Start + 1, N - (K - 1))
                    )
                end,
            dict:store({Start, K}, Result, Memo),
            Result
    end.