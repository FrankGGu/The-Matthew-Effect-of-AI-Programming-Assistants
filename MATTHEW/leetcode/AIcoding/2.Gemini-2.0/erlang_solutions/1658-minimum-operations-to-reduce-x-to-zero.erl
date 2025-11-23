-module(minimum_operations).
-export([min_operations/2]).

min_operations(Nums, X) ->
    Target = lists:sum(Nums) - X,
    Len = length(Nums),
    case Target == 0 of
        true -> Len;
        false ->
            case find_max_len(Nums, Target, 0, 0, 0, -1) of
                -1 -> -1;
                MaxLen -> Len - MaxLen
            end
    end.

find_max_len(Nums, Target, Start, CurrentSum, CurrentLen, MaxLen) ->
    case Start > length(Nums) - 1 of
        true -> MaxLen;
        false ->
            find_max_len_helper(Nums, Target, Start, 0, 0, 0, MaxLen)
    end.

find_max_len_helper(Nums, Target, Start, End, CurrentSum, CurrentLen, MaxLen) ->
    Len = length(Nums),
    case End > Len - 1 of
        true -> MaxLen;
        false ->
            NewSum = CurrentSum + lists:nth(End+1, Nums),
            case NewSum == Target of
                true ->
                    NewMaxLen = max(MaxLen, CurrentLen + 1);
                    find_max_len_helper(Nums, Target, Start, End + 1, NewSum, CurrentLen + 1, NewMaxLen);
                false ->
                    case NewSum < Target of
                        true ->
                            find_max_len_helper(Nums, Target, Start, End + 1, NewSum, CurrentLen + 1, MaxLen);
                        false ->
                            MaxLen
                    end
            end
    end.

max(A, B) ->
    if A > B -> A;
    true -> B
    end.