-module(reformat_phone_number).
-export([reformat/1]).

reformat(Number) ->
    Clean = [C || C <- Number, C /= $-, C /= $ ],
    Len = length(Clean),
    reformat(Clean, Len, []).

reformat([], _, Acc) ->
    lists:reverse(Acc);
reformat([A,B,C,D|T], 4, Acc) ->
    reformat(T, Len - 4, [C,B,A,$-, D | Acc]);
reformat([A,B,C|T], 3, Acc) ->
    reformat(T, Len - 3, [C,B,A | Acc]);
reformat([A,B|T], 2, Acc) ->
    reformat(T, Len - 2, [B,A | Acc]);
reformat([A|T], 1, Acc) ->
    reformat(T, Len - 1, [A | Acc]).