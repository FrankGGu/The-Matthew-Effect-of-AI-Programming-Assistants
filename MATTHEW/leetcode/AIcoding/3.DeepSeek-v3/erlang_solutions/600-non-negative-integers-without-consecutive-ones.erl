-module(solution).
-export([find_integers/1]).

find_integers(Num) ->
    S = integer_to_list(Num, 2),
    Len = length(S),
    DP = lists:duplicate(Len + 1, {0, 0}),
    {DP1, _} = lists:foldl(fun(_, {DPAcc, _}) -> 
        {Prev0, Prev1} = DPAcc,
        New0 = Prev0 + Prev1,
        New1 = Prev0,
        {New0, New1}
    end, {1, 1}, lists:seq(1, Len - 1)),
    Total = DP1,
    {Res, _} = lists:foldl(fun(I, {Acc, IsPrefixValid}) ->
        if
            not IsPrefixValid -> {Acc, false};
            true ->
                Char = lists:nth(I, S),
                if
                    Char == $1 ->
                        {Prev0, _} = element(I, DP),
                        NewAcc = Acc + Prev0,
                        if
                            I > 1, lists:nth(I - 1, S) == $1 ->
                                {NewAcc, false};
                            true ->
                                {NewAcc, true}
                        end;
                    true ->
                        {Acc, IsPrefixValid}
                end
        end
    end, {0, true}, lists:seq(1, Len)),
    Total - Res.