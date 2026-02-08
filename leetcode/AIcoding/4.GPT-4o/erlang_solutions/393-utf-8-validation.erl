-module(solution).
-compile([export_all]).

% Validate UTF-8 encoding
-spec valid_utf8([integer()]) -> boolean().
valid_utf8(Data) ->
    valid_utf8(Data, 0).

% Helper function to check each byte sequence
valid_utf8([], _) -> true;  % No more data to check, valid encoding.
valid_utf8([Byte | Rest], ExpectedBytes) when ExpectedBytes == 0 ->
    case valid_utf8_byte(Byte) of
        {1, N} -> valid_utf8(Rest, N - 1);
        {2, N} -> valid_utf8(Rest, N - 1);
        {3, N} -> valid_utf8(Rest, N - 1);
        {4, N} -> valid_utf8(Rest, N - 1);
        _ -> false
    end;
valid_utf8([Byte | Rest], ExpectedBytes) when ExpectedBytes > 0 ->
    case is_continuation_byte(Byte) of
        true -> valid_utf8(Rest, ExpectedBytes - 1);
        false -> false
    end.

% Check if byte follows UTF-8 pattern for 1-4 bytes
valid_utf8_byte(Byte) ->
    case (Byte band 255) of
        X when X bsr 7 == 0 -> {1, 0};  % 1-byte character
        X when X bsr 5 == 0x6 -> {2, 1}; % 2-byte character
        X when X bsr 4 == 0xE -> {3, 2}; % 3-byte character
        X when X bsr 3 == 0xF -> {4, 3}; % 4-byte character
        _ -> {0, 0} % Invalid UTF-8 start byte
    end.

% Check if byte is a continuation byte (10xxxxxx pattern)
is_continuation_byte(Byte) ->
    (Byte bsr 6) == 0x2.
