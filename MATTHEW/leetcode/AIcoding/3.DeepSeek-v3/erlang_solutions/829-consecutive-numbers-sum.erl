-spec consecutive_numbers_sum(N :: integer()) -> integer().
consecutive_numbers_sum(N) ->
    consecutive_numbers_sum(N, 1, 0).

consecutive_numbers_sum(N, K, Count) ->
    case K * (K - 1) div 2 < N of
        true ->
            case (N - K * (K - 1) div 2) rem K of
                0 ->
                    case (N - K * (K - 1) div 2) div K > 0 of
                        true -> consecutive_numbers_sum(N, K + 1, Count + 1);
                        false -> consecutive_numbers_sum(N, K + 1, Count)
                    end;
                _ -> consecutive_numbers_sum(N, K + 1, Count)
            end;
        false -> Count
    end.