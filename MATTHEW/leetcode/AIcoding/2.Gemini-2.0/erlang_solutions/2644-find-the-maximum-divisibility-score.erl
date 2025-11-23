-module(maximum_divisibility_score).
-export([max_divisibility_score/2]).

max_divisibility_score(Nums, Divisors) ->
    lists:foldl(
        fun(D, {BestD, BestScore}) ->
            Score = lists:foldl(
                fun(N, Acc) ->
                    if N rem D == 0 ->
                        Acc + 1
                    else
                        Acc
                    end
                end,
                0,
                Nums
            );
            if Score > BestScore ->
                {D, Score}
            else if Score == BestScore ->
                if D < BestD ->
                    {D, Score}
                else
                    {BestD, Score}
                end
            else
                {BestD, BestScore}
            end
        end,
        {hd(Divisors), -1},
        Divisors
    ).

max_divisibility_score(Nums, Divisors) ->
    {BestD, _} = lists:foldl(
        fun(D, {BestD, BestScore}) ->
            Score = lists:foldl(
                fun(N, Acc) ->
                    if N rem D == 0 ->
                        Acc + 1
                    else
                        Acc
                    end
                end,
                0,
                Nums
            );
            if Score > BestScore ->
                {D, Score}
            else if Score == BestScore andalso D < BestD->
                {D, Score}
            else
                {BestD, BestScore}
            end
        end,
        {hd(Divisors), score(hd(Divisors), Nums)},
        tl(Divisors)
    ),
    BestD.

score(D, Nums) ->
    lists:foldl(
        fun(N, Acc) ->
            if N rem D == 0 ->
                Acc + 1
            else
                Acc
            end
        end,
        0,
        Nums
    ).