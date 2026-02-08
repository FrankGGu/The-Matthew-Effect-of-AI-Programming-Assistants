-module(solution).
-export([ambiguous_coordinates/1]).

ambiguous_coordinates(S) ->
    NumStr = lists:sublist(S, 2, length(S) - 2),
    Len = length(NumStr),
    [ "(" ++ VL ++ ", " ++ VR ++ ")"
      || I <- lists:seq(1, Len - 1),
         LStr = lists:sublist(NumStr, I),
         RStr = lists:nthtail(I, NumStr),
         VL <- get_valid_numbers(LStr),
         VR <- get_valid_numbers(RStr)
    ].

get_valid_numbers(NumStr) ->
    case NumStr of
        [] -> [];
        "0" -> ["0"];
        [H|_] when H == $0 ->
            case lists:last(NumStr) of
                $0 -> []; % e.g., "010", "00" are invalid
                _ -> ["0." ++ lists:nthtail(1, NumStr)] % e.g., "01" -> "0.1"
            end;
        _ -> % starts with non-zero digit
            % Add NumStr itself (e.g., "123")
            Result = [NumStr],
            % Add numbers with decimal points (e.g., "1.23", "12.3")
            DecimalOptions = [
                Prefix ++ "." ++ Suffix
                || I <- lists:seq(1, length(NumStr) - 1),
                   Prefix = lists:sublist(NumStr, I),
                   Suffix = lists:nthtail(I, NumStr),
                   % Suffix cannot end with '0' for decimal numbers
                   lists:last(Suffix) /= $0
            ],
            Result ++ DecimalOptions
    end.