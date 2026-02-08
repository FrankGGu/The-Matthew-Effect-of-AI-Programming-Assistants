-module(solution).
-export([movesToChessboard/1]).

count_ones(List) ->
    lists:foldl(fun(X, Acc) -> Acc + X end, 0, List).

get_column(Board, ColIdx) ->
    lists:map(fun(Row) -> lists:nth(ColIdx + 1, Row) end, Board).

calculate_moves(N, Mismatches) ->
    case N rem 2 of
        0 -> %% N is even
            %% For even N, the number of mismatches with either target pattern (0101... or 1010...) must be even.
            %% If Mismatches (with 0101...) is odd, it's impossible.
            %% Otherwise, the minimum swaps is Mismatches / 2.
            case Mismatches rem 2 of
                0 -> Mismatches div 2;
                _ -> -1 %% Impossible
            end;
        1 -> %% N is odd
            %% For odd N, one of Mismatches (with 0101...) or (N - Mismatches) (with 1010...) must be even.
            %% We choose the target pattern that results in an even number of mismatches and divide by 2.
            case Mismatches rem 2 of
                0 -> Mismatches div 2; %% Target 0101... is possible
                _ -> (N - Mismatches) div 2 %% Target 1010... is possible
            end
    end.

movesToChessboard(Board) ->
    N = length(Board),

    %% Constraints: 2 <= N <= 30

    %% Get Board[0][0]
    R0C0 = lists:nth(1, hd(Board)),

    %% Step 1: Verify the chessboard pattern property
    %% board[i][j] == board[i][0] XOR board[0][j] XOR board[0][0]
    %% This ensures that all rows are either identical to row0 or its complement,
    %% and similarly for columns.
    IsPatternValid = lists:all(fun(I) ->
                                   RowI = lists:nth(I + 1, Board),
                                   RowI0 = lists:nth(1, RowI), %% Board[I][0]
                                   lists:all(fun(J) ->
                                                 Col0J = lists:nth(J + 1, hd(Board)), %% Board[0][J]
                                                 ExpectedVal = (RowI0 bxor Col0J bxor R0C0),
                                                 lists:nth(J + 1, RowI) == ExpectedVal
                                             end, lists:seq(0, N-1))
                               end, lists:seq(0, N-1)),

    case IsPatternValid of
        false -> -1;
        true ->
            %% Step 2: Verify counts of 0s and 1s in row0 and col0
            Row0 = hd(Board),
            Col0 = get_column(Board, 0),

            Row0Ones = count_ones(Row0),
            Col0Ones = count_ones(Col0),

            %% For a valid chessboard, the number of 0s and 1s in any row/column
            %% must differ by at most 1. (e.g., N/2 and N/2, or (N-1)/2 and (N+1)/2)
            IsValidCountBalance(OnesCount, Size) ->
                abs(OnesCount - (Size - OnesCount)) =< 1
            end,

            case IsValidCountBalance(Row0Ones, N) andalso IsValidCountBalance(Col0Ones, N) of
                false -> -1;
                true ->
                    %% Step 3: Verify counts of row patterns and column patterns
                    %% Based on the XOR property, the count of rows identical to Row0
                    %% is simply the count of Board[I][0] that are equal to R0C0.
                    NumRowsSameAsRow0 = lists:foldl(fun(I, Acc) ->
                                                        case lists:nth(1, lists:nth(I + 1, Board)) == R0C0 of
                                                            true -> Acc + 1;
                                                            false -> Acc
                                                        end
                                                    end, 0, lists:seq(0, N-1)),

                    %% Similarly for columns
                    NumColsSameAsCol0 = lists:foldl(fun(J, Acc) ->
                                                        case lists:nth(J + 1, hd(Board)) == R0C0 of
                                                            true -> Acc + 1;
                                                            false -> Acc
                                                        end
                                                    end, 0, lists:seq(0, N-1)),

                    %% The counts of row patterns (Row0 vs complement(Row0)) and
                    %% column patterns (Col0 vs complement(Col0)) must also be balanced.
                    case IsValidCountBalance(NumRowsSameAsRow0, N) andalso IsValidCountBalance(NumColsSameAsCol0, N) of
                        false -> -1;
                        true ->
                            %% All validity conditions passed. Calculate minimum swaps.

                            %% Calculate row mismatches with target 0101... pattern for Row0
                            RowMismatches = lists:foldl(fun(Idx, Acc) ->
                                                            TargetVal = Idx rem 2,
                                                            case lists:nth(Idx + 1, Row0) == TargetVal of
                                                                true -> Acc;
                                                                false -> Acc + 1
                                                            end
                                                        end, 0, lists:seq(0, N-1)),

                            %% Calculate column mismatches with target 0101... pattern for Col0
                            ColMismatches = lists:foldl(fun(Idx, Acc) ->
                                                            TargetVal = Idx rem 2,
                                                            case lists:nth(Idx + 1, Col0) == TargetVal of
                                                                true -> Acc;
                                                                false -> Acc + 1
                                                            end
                                                        end, 0, lists:seq(0, N-1)),

                            RowMoves = calculate_moves(N, RowMismatches),
                            ColMoves = calculate_moves(N, ColMismatches),

                            case {RowMoves, ColMoves} of
                                {-1, _} -> -1;
                                {_, -1} -> -1;
                                {R, C} -> R + C
                            end
                    end
            end
    end.