-module(special_permutations).
-export([special_permutations/1]).

special_permutations(Nums) ->
    N = length(Nums),
    Memo = dict:new(),
    special_permutations_helper(Nums, [], 0, Memo, N).

special_permutations_helper(_Nums, Perm, Count, _Memo, N) when length(Perm) == N ->
    1;
special_permutations_helper(Nums, Perm, Count, Memo, N) ->
    Key = {Perm, Count},
    case dict:find(Key, Memo) of
        {ok, Value} ->
            Value;
        error ->
            Result = lists:foldl(
                fun(I, Acc) ->
                    case lists:member(I, Perm) of
                        true ->
                            Acc;
                        false ->
                            case (length(Perm) == 0) or (abs(lists:last(Perm) - lists:nth(I, Nums)) rem 1 == 0) of
                                true ->
                                    Acc + special_permutations_helper(
                                        Nums, Perm ++ [lists:nth(I, Nums)], I, Memo, N
                                    );
                                false ->
                                    Acc
                            end
                    end
                end,
                0,
                lists:seq(1, N)
            ),
            dict:store(Key, Result, Memo),
            Result
    end.