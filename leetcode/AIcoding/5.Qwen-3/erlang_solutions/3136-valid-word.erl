-module(valid_word).
-export([valid_word/1]).

valid_word(Word) ->
    case string:split(Word, " ") of
        [A, B] when is_binary(A), is_binary(B) ->
            case string:is_lower(A) andalso string:is_upper(B) of
                true -> true;
                _ -> false
            end;
        _ -> false
    end.