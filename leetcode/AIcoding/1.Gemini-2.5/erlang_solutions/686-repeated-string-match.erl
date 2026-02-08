-module(repeated_string_match).
-export([repeatedStringMatch/2]).

repeatedStringMatch(A, B) ->
    A_bin = list_to_binary(A),
    B_bin = list_to_binary(B),
    N_a = byte_size(A_bin),
    N_b = byte_size(B_bin),

    % Calculate the minimum number of repetitions needed for A to be at least as long as B.
    % This is equivalent to ceil(N_b / N_a).
    MinRepeats = (N_b + N_a - 1) div N_a,

    % Check if B is a substring of A repeated MinRepeats times.
    CurrentA_bin = binary:copy(A_bin, MinRepeats),
    case binary:match(CurrentA_bin, B_bin) of
        nomatch ->
            % If not found, check A repeated (MinRepeats + 1) times.
            % This covers cases where B starts in one A and ends in the next.
            CurrentA_bin_plus1 = binary:copy(A_bin, MinRepeats + 1),
            case binary:match(CurrentA_bin_plus1, B_bin) of
                nomatch ->
                    % If still not found, check A repeated (MinRepeats + 2) times.
                    % This covers cases where B starts near the end of an A, spans
                    % several full A's, and ends near the beginning of another A.
                    % Any valid match must occur within a string of A's of length
                    % at most N_b + 2*N_a, which corresponds to at most MinRepeats + 2 copies.
                    CurrentA_bin_plus2 = binary:copy(A_bin, MinRepeats + 2),
                    case binary:match(CurrentA_bin_plus2, B_bin) of
                        nomatch ->
                            -1; % B cannot be formed by repeating A
                        _ ->
                            MinRepeats + 2
                    end;
                _ ->
                    MinRepeats + 1
            end;
        _ ->
            MinRepeats
    end.