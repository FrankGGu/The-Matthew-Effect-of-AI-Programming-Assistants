-module(solution).
-export([solve/2]).

solve(N, X) ->
    NChars = string:to_list(N),
    XChar = $0 + X,

    ResultChars =
        case NChars of
            [$- | _] ->
                [$- | insert_for_negative(tl(NChars), XChar, [])];
            _ ->
                insert_for_positive(NChars, XChar, [])
        end,

    string:from_list(ResultChars).

insert_for_positive([], XChar, Acc) ->
    lists:reverse([XChar | Acc]);
insert_for_positive([H | T], XChar, Acc) when XChar > H ->
    lists:reverse(Acc) ++ [XChar, H | T];
insert_for_positive([H | T], XChar, Acc) ->
    insert_for_positive(T, XChar, [H | Acc]).

insert_for_negative([], XChar, Acc) ->
    lists:reverse([XChar | Acc]);
insert_for_negative([H | T], XChar, Acc) when XChar < H ->
    lists:reverse(Acc) ++ [XChar, H | T];
insert_for_negative([H | T], XChar, Acc) ->
    insert_for_negative(T, XChar, [H | Acc]).