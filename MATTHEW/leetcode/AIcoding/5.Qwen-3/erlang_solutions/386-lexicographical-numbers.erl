-module(lexicographical_numbers).
-export([lexical_order/1]).

lexical_order(N) ->
    lexical_order(N, 1, []).

lexical_order(_, N, Acc) when N > N ->
    lists:reverse(Acc);
lexical_order(N, Current, Acc) ->
    case Current of
        _ when Current > N ->
            lexical_order(N, Current div 10 + 1, Acc);
        _ ->
            lexical_order(N, Current * 10, [Current | Acc])
    end.