-spec min_moves_to_capture_the_queen(A :: integer(), B :: integer(), C :: integer(), D :: integer(), E :: integer(), F :: integer()) -> integer().
min_moves_to_capture_the_queen(A, B, C, D, E, F) ->
    case (A == E) and (C == E) and ((B < F and F < D) or (D < F and F < B)) of
        true -> 2;
        false ->
            case (B == F) and (D == F) and ((A < E and E < C) or (C < E and E < A)) of
                true -> 2;
                false ->
                    case (A + B == E + F) and (C + D == E + F) and ((A < E and E < C) or (C < E and E < A)) of
                        true -> 2;
                        false ->
                            case (A - B == E - F) and (C - D == E - F) and ((A < E and E < C) or (C < E and E < A)) of
                                true -> 2;
                                false ->
                                    case (A == E) or (B == F) or (A + B == E + F) or (A - B == E - F) of
                                        true -> 1;
                                        false -> 2
                                    end
                            end
                    end
            end
    end.