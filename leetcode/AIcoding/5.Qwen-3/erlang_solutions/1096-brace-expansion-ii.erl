-module(brace_expansion_ii).
-export([expand/1]).

expand(Str) ->
    expand(Str, []).

expand([], Acc) ->
    lists:usort(Acc);
expand([${ | Rest], Acc) ->
    {Brace, Rest2} = collect_brace(Rest, []),
    {Options, Rest3} = parse_brace(Brace),
    expand(Rest3, lists:foldl(fun(Option, AccIn) -> expand(Option ++ Rest2, AccIn) end, Acc, Options));
expand([C | Rest], Acc) ->
    expand(Rest, [Acc ++ [C]]).

collect_brace([], Acc) ->
    {lists:reverse(Acc), []};
collect_brace([$} | Rest], Acc) ->
    {lists:reverse(Acc), Rest};
collect_brace([C | Rest], Acc) ->
    collect_brace(Rest, [C | Acc]).

parse_brace(Brace) ->
    parse_brace(Brace, [], []).

parse_brace([], [], Acc) ->
    {lists:reverse(Acc), []};
parse_brace([], Current, Acc) ->
    {lists:reverse([lists:reverse(Current) | Acc]), []};
parse_brace([$, | Rest], Current, Acc) ->
    parse_brace(Rest, [], [lists:reverse(Current) | Acc]);
parse_brace([C | Rest], Current, Acc) ->
    parse_brace(Rest, [C | Current], Acc).