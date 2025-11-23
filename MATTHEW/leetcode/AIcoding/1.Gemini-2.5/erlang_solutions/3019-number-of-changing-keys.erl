-module(solution).
-export([count_changing_keys/1]).

count_changing_keys(S) ->
    count_changing_keys_rec(S, 0).

count_changing_keys_rec([], Acc) ->
    Acc;
count_changing_keys_rec([_], Acc) ->
    Acc;
count_changing_keys_rec([H1, H2 | T], Acc) ->
    LowerH1 = string:to_lower(H1),
    LowerH2 = string:to_lower(H2),
    case LowerH1 == LowerH2 of
        true -> count_changing_keys_rec([H2 | T], Acc);
        false -> count_changing_keys_rec([H2 | T], Acc + 1)
    end.