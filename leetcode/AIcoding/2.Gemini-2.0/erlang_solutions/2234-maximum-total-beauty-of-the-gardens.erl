-module(maximum_beauty).
-export([maximum_beauty/3]).

maximum_speculative(Gardens, NewFlowers, Target, Full, Partial) ->
    N = length(Gardens),
    {SortedGardens, _} = lists:sort([{G, I} || {G, I} <- lists:zip(Gardens, lists:seq(1, N))]),
    maximum_speculative(SortedGardens, NewFlowers, Target, Full, Partial, 0).

maximum_speculative([], _, _, _, _, Acc) ->
    Acc;
maximum_speculative([G | Rest], NewFlowers, Target, Full, Partial, Acc) ->
    maximum_speculative(Rest, NewFlowers, Target, Full, Partial, Acc + G).

maximum_beauty(Gardens, NewFlowers, Target) ->
    N = length(Gardens),
    SortedGardens = lists:sort(Gardens),
    F = fun(X) -> X end,
    maximum_beauty_helper(SortedGardens, NewFlowers, Target, 0, 0, F).

maximum_beauty_helper([], _, _, Full, _, _) ->
    Full;
maximum_beauty_helper(Gardens, NewFlowers, Target, Full, Partial, F) ->
    N = length(Gardens),
    maximum_beauty_helper(Gardens, NewFlowers, Target, Full, Partial, F, N).

maximum_beauty_helper(Gardens, NewFlowers, Target, Full, Partial, F, NumFull) ->
    if
        NumFull < 0 ->
            0;
        true ->
            {FullNum, Remainder} = find_max_beauty(Gardens, NewFlowers, Target, NumFull),
            max(FullNum * Target + Remainder, maximum_beauty_helper(Gardens, NewFlowers, Target, Full, Partial, F, NumFull - 1))
    end.

find_max_beauty(Gardens, NewFlowers, Target, NumFull) ->
    N = length(Gardens),
    {SortedGardens, _} = lists:sort([{G, I} || {G, I} <- lists:zip(Gardens, lists:seq(1, N))]),
    find_max_beauty(SortedGardens, NewFlowers, Target, NumFull, 0, 0, 0).

find_max_beauty(Gardens, NewFlowers, Target, NumFull, Acc, Sum, Index) ->
    N = length(Gardens),
    if
        Index >= N ->
            if
                NumFull > 0 ->
                    {0,0};
                true ->
                    {0, 0}
            end;
        true ->
            G = lists:nth(Index+1, Gardens),
            if
                Index < N - NumFull ->
                    Needed = Target - G,
                    if
                        NewFlowers >= Needed ->
                            find_max_beauty(Gardens, NewFlowers - Needed, Target, NumFull, Acc, Sum + Target, Index + 1);
                        true ->
                            Partial = (Sum + G + NewFlowers) / (Index + 1),
                            if
                                Partial > Target ->
                                    {0,0};
                                true ->
                                    {0, trunc(Partial)}
                            end
                    end;
                true ->
                    if
                        G < Target ->
                            Needed = Target - G,
                            if
                                NewFlowers >= Needed ->
                                    find_max_beauty(Gardens, NewFlowers - Needed, Target, NumFull, Acc + 1, Sum + Target, Index + 1);
                                true ->
                                    {0,0}
                            end;
                        true ->
                            find_max_beauty(Gardens, NewFlowers, Target, NumFull, Acc + 1, Sum + Target, Index + 1)
                    end
            end
    end.