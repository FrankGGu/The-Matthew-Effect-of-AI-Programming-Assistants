-module(solution).
-export([utf8_validation/1]).

utf8_validation(Data) ->
    validate(Data, 0).

validate([], 0) ->
    true;
validate([], _ExpectedContinuationBytes) ->
    false;
validate([H | T], 0) ->
    case H of
        Byte when (Byte band 16#80) == 0 ->
            validate(T, 0);
        Byte when (Byte band 16#E0) == 16#C0 ->
            validate(T, 1);
        Byte when (Byte band 16#F0) == 16#E0 ->
            validate(T, 2);
        Byte when (Byte band 16#F8) == 16#F0 ->
            validate(T, 3);
        _ ->
            false
    end;
validate([H | T], ExpectedContinuationBytes) when ExpectedContinuationBytes > 0 ->
    case H of
        Byte when (Byte band 16#C0) == 16#80 ->
            validate(T, ExpectedContinuationBytes - 1);
        _ ->
            false
    end.