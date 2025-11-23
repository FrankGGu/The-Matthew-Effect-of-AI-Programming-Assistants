-module(longest_unequal_adjacent_groups_subsequence_ii).
-export([longest_unequal_adjacent_groups_subsequence_ii/2]).

longest_unequal_adjacent_groups_subsequence_ii(Words, Groups) ->
    N = length(Words),
    DP = lists:duplicate(N, 1),
    for(1, N - 1, fun(I) ->
        for(0, I - 1, fun(J) ->
            if
                lists:nth(I + 1, Groups) /= lists:nth(J + 1, Groups) andalso is_subsequence(lists:nth(J + 1, Words), lists:nth(I + 1, Words)) ->
                    DP ! (I, max(DP !! I, (DP !! J) + 1));
                true ->
                    ok
            end
        end)
    end),
    lists:max(DP).

is_subsequence(S1, S2) ->
    is_subsequence(S1, S2, 1, 1).

is_subsequence(S1, S2, I1, I2) ->
    Len1 = length(S1),
    Len2 = length(S2),
    if
        I1 > Len1 ->
            true;
        I2 > Len2 ->
            false;
        true ->
            if
                lists:nth(I1, S1) == lists:nth(I2, S2) ->
                    is_subsequence(S1, S2, I1 + 1, I2 + 1);
                true ->
                    is_subsequence(S1, S2, I1, I2 + 1)
            end
    end.

for(Start, End, Fun) ->
    for(Start, End, Fun, ok).

for(I, End, Fun, Acc) when I > End ->
    Acc;
for(I, End, Fun, Acc) ->
    Fun(I),
    for(I + 1, End, Fun, Acc).