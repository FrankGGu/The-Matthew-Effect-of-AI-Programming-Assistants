-module(solution).
-export([is_additive_number/1]).

is_additive_number(Num) ->
    case Num of
        "" -> false;
        _ -> check(Num, 0, 0, 0, 0)
    end.

check(Num, Index, PrevPrev, Prev, Count) ->
    Length = length(Num),
    if
        Index == Length ->
            Count >= 3;
        true ->
            case Count < 2 of
                true ->
                    case Num of
                        [Ch | Rest] ->
                            case Ch of
                                $0 when Index == 0, length(Rest) > 0 ->
                                    false;
                                _ ->
                                    {NumVal, RestNum} = get_num(Num, Index, 0),
                                    check(RestNum, 0, Prev, NumVal, Count + 1)
                            end;
                        _ ->
                            false
                    end;
                false ->
                    Sum = PrevPrev + Prev,
                    SumStr = integer_to_list(Sum),
                    SumLen = length(SumStr),
                    case lists:prefix(SumStr, lists:nthtail(Index, Num)) of
                        true ->
                            check(Num, Index + SumLen, Prev, Sum, Count + 1);
                        false ->
                            false
                    end
            end
    end.

get_num(Num, Index, Acc) ->
    case Num of
        [] -> {Acc, []};
        [Ch | Rest] ->
            Digit = Ch - $0,
            NewAcc = Acc * 10 + Digit,
            get_num(Rest, Index + 1, NewAcc)
    end.