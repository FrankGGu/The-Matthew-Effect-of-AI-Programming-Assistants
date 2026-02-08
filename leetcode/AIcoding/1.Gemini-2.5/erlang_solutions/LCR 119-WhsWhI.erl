-module(solution).
-export([longestConsecutive/1]).

longestConsecutive(Nums) ->
    case Nums of
        [] -> 0;
        _ ->
            Set = gb_sets:from_list(Nums),
            lists:foldl(
                fun(N, MaxLength) ->
                    case gb_sets:is_member(N - 1, Set) of
                        true ->
                            MaxLength;
                        false ->
                            CurrentNum = N,
                            CurrentLength = 1,
                            NewLength = count_sequence(CurrentNum + 1, CurrentLength, Set),
                            max(MaxLength, NewLength)
                    end
                end,
                0,
                Nums
            )
    end.

count_sequence(Num, AccLength, Set) ->
    case gb_sets:is_member(Num, Set) of
        true ->
            count_sequence(Num + 1, AccLength + 1, Set);
        false ->
            AccLength
    end.