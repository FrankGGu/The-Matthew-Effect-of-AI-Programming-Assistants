-module(solution).
-export([get_words_in_longest_subsequence/2]).

get_words_in_longest_subsequence(Words, Groups) ->
    N = length(Words),
    DP = lists:duplicate(N, 1),
    Prev = lists:duplicate(N, -1),
    {DP1, Prev1} = lists:foldl(fun(I, {Dp, P}) ->
        lists:foldl(fun(J, {DpAcc, PAcc}) ->
            if
                (lists:nth(J + 1, Groups) /= lists:nth(I + 1, Groups)) andalso
                (length(lists:nth(J + 1, Words)) == length(lists:nth(I + 1, Words))) ->
                    if
                        (lists:nth(J + 1, DpAcc) + 1) > lists:nth(I + 1, DpAcc) ->
                            NewDp = list_update(DpAcc, I + 1, lists:nth(J + 1, DpAcc) + 1),
                            NewP = list_update(PAcc, I + 1, J),
                            {NewDp, NewP};
                        true ->
                            {DpAcc, PAcc}
                    end;
                true ->
                    {DpAcc, PAcc}
            end
        end, {Dp, P}, lists:seq(0, I - 1))
    end, {DP, Prev}, lists:seq(1, N - 1)),
    MaxLen = lists:max(DP1),
    MaxIndex = index_of(MaxLen, DP1),
    Result = build_result(Words, Prev1, MaxIndex, []),
    lists:reverse(Result).

list_update(List, Index, Value) ->
    {Left, [_ | Right]} = lists:split(Index - 1, List),
    Left ++ [Value | Right].

index_of(Value, List) ->
    index_of(Value, List, 0).

index_of(Value, [Value | _], Index) ->
    Index;
index_of(Value, [_ | Rest], Index) ->
    index_of(Value, Rest, Index + 1);
index_of(_, [], _) ->
    -1.

build_result(_, _, -1, Acc) ->
    Acc;
build_result(Words, Prev, Index, Acc) ->
    build_result(Words, Prev, lists:nth(Index + 1, Prev), [lists:nth(Index + 1, Words) | Acc]).