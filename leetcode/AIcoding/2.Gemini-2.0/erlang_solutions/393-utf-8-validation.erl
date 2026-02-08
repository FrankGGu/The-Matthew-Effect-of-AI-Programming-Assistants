-module(utf8_validation).
-export([validUtf8/1]).

validUtf8(Data) ->
    validUtf8_helper(Data, 0).

validUtf8_helper([], 0) ->
    true;
validUtf8_helper([], _) ->
    false;
validUtf8_helper([H|T], 0) ->
    case H of
        X when X >= 0 andalso X < 128 ->
            validUtf8_helper(T, 0);
        X when X >= 192 andalso X < 224 ->
            validUtf8_helper(T, 1);
        X when X >= 224 andalso X < 240 ->
            validUtf8_helper(T, 2);
        X when X >= 240 andalso X < 248 ->
            validUtf8_helper(T, 3);
        _ ->
            false
    end;
validUtf8_helper([H|T], N) ->
    case H of
        X when X >= 128 andalso X < 192 ->
            validUtf8_helper(T, N - 1);
        _ ->
            false
    end.