-module(solution).
-export([entityParser/1]).

entityParser(Text) ->
    parse(Text, []).

parse([], Acc) ->
    lists:reverse(Acc);
parse([$& | Rest], Acc) ->
    case Rest of
        "quot;" ++ Tail -> parse(Tail, [$" | Acc]);
        "apos;" ++ Tail -> parse(Tail, [$' | Acc]);
        "frasl;" ++ Tail -> parse(Tail, [$/ | Acc]);
        "gt;" ++ Tail   -> parse(Tail, [$> | Acc]);
        "lt;" ++ Tail   -> parse(Tail, [< | Acc]);
        "amp;" ++ Tail  -> parse([$& | Tail], Acc);
        _ -> parse(Rest, [$& | Acc])
    end;
parse([H | T], Acc) ->
    parse(T, [H | Acc]).