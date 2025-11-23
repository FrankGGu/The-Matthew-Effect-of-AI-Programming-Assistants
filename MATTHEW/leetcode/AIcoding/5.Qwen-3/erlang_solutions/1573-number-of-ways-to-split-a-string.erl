-module(solution).
-export([num_ways/1]).

num_ways(S) ->
    N = erlang:length(S),
    Count = count_ones(S),
    if
        Count < 2 -> 0;
        true ->
            Left = lists:seq(1, N-1),
            Right = lists:seq(1, N-1),
            lists:foldl(fun(I, Acc) ->
                                if
                                    I == N-1 -> Acc;
                                    true ->
                                        LeftCount = count_ones_substring(S, 0, I),
                                        RightCount = count_ones_substring(S, I+1, N-1),
                                        if
                                            LeftCount == Count - RightCount -> Acc + 1;
                                            true -> Acc
                                        end
                                end
                            end, 0, Left)
    end.

count_ones(S) ->
    count_ones(S, 0).

count_ones([], Acc) -> Acc;
count_ones([$1 | T], Acc) -> count_ones(T, Acc + 1);
count_ones([_|T], Acc) -> count_ones(T, Acc).

count_ones_substring(S, Start, End) ->
    count_ones_substring(S, Start, End, 0).

count_ones_substring(_, End, End, Acc) -> Acc;
count_ones_substring(S, Start, End, Acc) ->
    case Start of
        Start when Start > End -> Acc;
        _ ->
            Char = lists:nth(Start + 1, S),
            NewAcc = if
                         Char == $1 -> Acc + 1;
                         true -> Acc
                     end,
            count_ones_substring(S, Start + 1, End, NewAcc)
    end.