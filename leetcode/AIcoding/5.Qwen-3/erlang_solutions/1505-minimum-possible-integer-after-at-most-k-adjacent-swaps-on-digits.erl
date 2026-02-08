-module(minimum_possible_integer_after_at_most_k_adjacent_swaps_on_digits).
-export([minInteger/2]).

minInteger(Num, K) ->
    Digits = [C - $0 || C <- Num],
    Len = length(Digits),
    List = lists:seq(0, Len - 1),
    {Result, _} = find_min(Digits, K, List, Len),
    lists:flatten([integer_to_list(D) || D <- Result]).

find_min(Digits, K, Indices, Len) when K == 0 ->
    {lists:map(fun(I) -> lists:nth(I + 1, Digits) end, Indices), K};
find_min(Digits, K, Indices, Len) ->
    MinPos = find_min_pos(Digits, Indices, K),
    {MinVal, NewIndices} = remove_and_shift(Digits, MinPos, Indices),
    {MinValList, NewK} = find_min(Digits, K - MinPos, NewIndices, Len),
    {MinVal ++ MinValList, NewK}.

find_min_pos(Digits, Indices, K) ->
    Len = length(Indices),
    find_min_pos(Digits, Indices, K, 0, 0).

find_min_pos(_, [], _, _, MinPos) ->
    MinPos;
find_min_pos(Digits, [I | Rest], K, Pos, MinPos) ->
    if
        Pos > K ->
            MinPos;
        true ->
            Current = lists:nth(I + 1, Digits),
            case is_better(Digits, I, Rest, Current) of
                true ->
                    find_min_pos(Digits, Rest, K, Pos + 1, I);
                false ->
                    find_min_pos(Digits, Rest, K, Pos + 1, MinPos)
            end
    end.

is_better(_, _, [], _) ->
    true;
is_better(Digits, I, [J | Rest], Current) ->
    Other = lists:nth(J + 1, Digits),
    if
        Other < Current ->
            true;
        true ->
            is_better(Digits, I, Rest, Current)
    end.

remove_and_shift(Digits, Index, Indices) ->
    {Left, [Index | Right]} = lists:split(Index, Indices),
    NewIndices = Left ++ Right,
    MinVal = lists:nth(Index + 1, Digits),
    {MinVal, NewIndices}.