-module(reformat_the_string).
-export([reformat/1]).

reformat(S) ->
    {Letters, Digits} = lists:partition(fun(C) -> C >= $a andalso C =< $z end, S),
    case length(Letters) - length(Digits) of
        0 -> reformat_helper(Letters, Digits, []);
        1 -> reformat_helper(Letters, Digits, []);
        -1 -> reformat_helper(Digits, Letters, []);
        _ -> []
    end.

reformat_helper([], [], Acc) ->
    lists:reverse(Acc);
reformat_helper([L|Ls], [D|Ds], Acc) ->
    reformat_helper(Ls, Ds, [D, L | Acc]);
reformat_helper([L|Ls], [], Acc) ->
    reformat_helper(Ls, [], [L | Acc]);
reformat_helper([], [D|Ds], Acc) ->
    reformat_helper([], Ds, [D | Acc]).