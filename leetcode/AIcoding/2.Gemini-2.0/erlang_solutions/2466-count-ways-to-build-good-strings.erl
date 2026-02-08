-module(count_good_strings).
-export([countGoodStrings/4]).

countGoodStrings(Low, High, Zero, One) ->
    countGoodStrings(Low, High, Zero, One, 0, 1000000007, 0, []).

countGoodStrings(Low, High, Zero, One, Len, Mod, Acc, Memo) ->
    case lists:keyfind(Len, 1, Memo) of
        false ->
            case Len > High of
                true ->
                    {Acc, Memo};
                false ->
                    NewAcc = case Len >= Low of
                                 true ->
                                     (Acc + 1) rem Mod;
                                 false ->
                                     Acc
                             end,
                    {NewAcc1, NewMemo1} = countGoodStrings(Low, High, Zero, One, Len + Zero, Mod, NewAcc, [{Len, NewAcc}|Memo]),
                    {NewAcc2, NewMemo2} = countGoodStrings(Low, High, Zero, One, Len + One, Mod, NewAcc1, NewMemo1),
                    {NewAcc2, NewMemo2};
            end;
        {Len, Value} ->
            {Value, Memo}
    end.