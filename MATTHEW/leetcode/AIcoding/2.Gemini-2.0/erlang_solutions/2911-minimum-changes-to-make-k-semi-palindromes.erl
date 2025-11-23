-module(minimum_changes_k_semi_palindromes).
-export([solve/1]).

solve(S) ->
    length(S).

-export([min_changes/2]).

min_changes(S, K) ->
    N = length(S),
    C = list_to_tuple(S),
    Memo = dict:new(),
    min_changes_helper(C, 0, N - 1, K, Memo).

min_changes_helper(C, I, J, 1, Memo) ->
    case dict:is_key({I, J, 1}, Memo) of
        true -> dict:fetch({I, J, 1}, Memo);
        false ->
            Result = semi_palindrome_changes(C, I, J),
            Memo1 = dict:put({I, J, 1}, Result, Memo),
            Memo1
    end;
min_changes_helper(C, I, J, K, Memo) when K > 1 ->
    case dict:is_key({I, J, K}, Memo) of
        true -> dict:fetch({I, J, K}, Memo);
        false ->
            MinChanges = lists:foldl(
                fun(M, Acc) ->
                    Acc1 = min_changes_helper(C, I, M, 1, Memo),
                    Acc2 = min_changes_helper(C, M + 1, J, K - 1, Memo),
                    min(Acc, Acc1 + Acc2)
                end,
                infinity,
                lists:seq(I, J - 1)
            ),
            Memo1 = dict:put({I, J, K}, MinChanges, Memo),
            Memo1
    end.

semi_palindrome_changes(C, I, J) ->
    N = J - I + 1,
    if N < 2 then
        0
    else
        lists:foldl(
            fun(Len, Acc) ->
                Changes = num_changes(C, I, J, Len),
                min(Acc, Changes)
            end,
            infinity,
            lists:seq(1, N)
        )
    end.

num_changes(C, I, J, Len) ->
    N = J - I + 1,
    if N rem Len /= 0 then
        infinity
    else
        NumChunks = N div Len,
        lists:foldl(
            fun(ChunkNum, Acc) ->
                ChunkStart = I + (ChunkNum - 1) * Len,
                ChunkEnd = ChunkStart + Len - 1,
                Acc + changes_for_chunk(C, ChunkStart, ChunkEnd)
            end,
            0,
            lists:seq(1, NumChunks)
        )
    end.

changes_for_chunk(C, I, J) ->
    Len = J - I + 1,
    lists:foldl(
        fun(Idx, Acc) ->
            if element(I + Idx - 1 + 1, C) /= element(J - Idx + 1 + 1, C) then
                Acc + 1
            else
                Acc
            end
        end,
        0,
        lists:seq(1, Len div 2)
    ).

infinity ->
    16#3f3f3f3f.