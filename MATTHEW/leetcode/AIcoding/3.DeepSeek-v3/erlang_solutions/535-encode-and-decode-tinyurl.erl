-module(tinyurl).
-export([init/0, encode/1, decode/1]).

init() ->
    ets:new(url_map, [set, public, named_table]),
    ets:new(code_map, [set, public, named_table]),
    ok.

encode(LongUrl) ->
    case ets:lookup(url_map, LongUrl) of
        [] ->
            Code = generate_code(),
            ets:insert(url_map, {LongUrl, Code}),
            ets:insert(code_map, {Code, LongUrl}),
            "http://tinyurl.com/" ++ Code;
        [{_, Code}] ->
            "http://tinyurl.com/" ++ Code
    end.

decode(ShortUrl) ->
    Code = lists:nthtail(19, ShortUrl),
    case ets:lookup(code_map, Code) of
        [] -> "";
        [{_, LongUrl}] -> LongUrl
    end.

generate_code() ->
    Chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789",
    lists:foldl(
        fun(_, Acc) ->
            [lists:nth(rand:uniform(length(Chars)), Chars] ++ Acc
        end,
        "",
        lists:seq(1, 6)
    ).