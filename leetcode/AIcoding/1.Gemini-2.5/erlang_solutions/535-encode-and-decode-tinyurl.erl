-module(solution).
-export([encode/1, decode/1]).

-define(TABLE, tinyurl_map).
-define(BASE62_CHARS, "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ").

init() ->
    case ets:whereis(?TABLE) of
        undefined ->
            ets:new(?TABLE, [set, public, named_table]),
            ets:insert(?TABLE, {counter, 1});
        _ ->
            ok
    end.

encode(LongUrl) ->
    init(),
    Table = ?TABLE,

    case ets:lookup(Table, {long, LongUrl}) of
        [{{long, LongUrl}, ShortUrl}] ->
            ShortUrl;
        [] ->
            {counter, CurrentCounter} = ets:lookup_element(Table, counter, 2),
            NewCounter = CurrentCounter + 1,
            ets:insert(Table, {counter, NewCounter}),

            ShortUrl = integer_to_base62(CurrentCounter),

            ets:insert(Table, {{long, LongUrl}, ShortUrl}),
            ets:insert(Table, {{short, ShortUrl}, LongUrl}),

            ShortUrl
    end.

decode(ShortUrl) ->
    init(),
    Table = ?TABLE,
    case ets:lookup(Table, {short, ShortUrl}) of
        [{{short, ShortUrl}, LongUrl}] ->
            LongUrl;
        [] ->
            undefined
    end.

integer_to_base62(N) when N >= 0 ->
    integer_to_base62(N, ?BASE62_CHARS, []).

integer_to_base62(0, _Base62Chars, Acc) ->
    case Acc of
        [] -> "0";
        _ -> lists:reverse(Acc)
    end;
integer_to_base62(N, Base62Chars, Acc) ->
    Remainder = N rem 62,
    Char = lists:nth(Remainder + 1, Base62Chars),
    integer_to_base62(N div 62, Base62Chars, [Char | Acc]).