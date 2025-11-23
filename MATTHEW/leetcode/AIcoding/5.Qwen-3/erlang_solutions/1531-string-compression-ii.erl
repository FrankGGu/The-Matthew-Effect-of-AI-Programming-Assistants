-module(string_compression_ii).
-export([get_length_of_optimal_compression/2]).

get_length_of_optimal_compression(S, K) ->
    N = length(S),
    {_, _, MinLen} = dp(S, N, K, 0, 0, 0, #{}),
    MinLen.

dp(S, N, K, I, J, Count, Memo) ->
    Key = {I, J, Count},
    case maps:find(Key, Memo) of
        {ok, Val} -> {I, J, Val};
        error ->
            if
                I == N ->
                    {I, J, 0};
                true ->
                    CurrentChar = lists:nth(I + 1, S),
                    NextI = I + 1,
                    {NewI, NewJ, Cost} = if
                                            J == 0 orelse lists:nth(J, S) /= CurrentChar ->
                                                {NextI, I + 1, 1};
                                            true ->
                                                {NextI, J + 1, Count + 1}
                                        end,
                    {NewI, NewJ, Cost1} = dp(S, N, K, NewI, NewJ, Count + 1, Memo),
                    {NewI, NewJ, Cost2} = if
                                            K > 0 ->
                                                {NextI, J, Count + 1 - (if Count == 0 -> 0; true -> 1 end)},
                                                {NewI, NewJ, Cost3} = dp(S, N, K - 1, NewI, NewJ, Count + 1 - (if Count == 0 -> 0; true -> 1 end), Memo),
                                                {NewI, NewJ, Cost3};
                                            true ->
                                                {NewI, NewJ, infinity}
                                        end,
                    MinCost = min(Cost1, Cost2),
                    NewMemo = maps:put(Key, MinCost, Memo),
                    {NewI, NewJ, MinCost}
            end
    end.