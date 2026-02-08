-module(solution).
-export([max_score/1]).

max_score(Nums) ->
    N = length(Nums),
    case N of
        0 -> 0;
        1 -> hd(Nums);
        _ ->
            NumsArray = array:from_list(Nums),

            InitialMaxSuffixDp = array:get(N - 1, NumsArray),

            max_score_helper(N - 2, NumsArray, InitialMaxSuffixDp)
    end.

max_score_helper(I, NumsArray, MaxSuffixDp) when I >= 0 ->
    CurrentNum = array:get(I, NumsArray),
    CurrentDpI = CurrentNum + MaxSuffixDp,

    NewMaxSuffixDp = max(MaxSuffixDp, CurrentDpI),

    case I of
        0 -> CurrentDpI;
        _ -> max_score_helper(I - 1, NumsArray, NewMaxSuffixDp)
    end;
max_score_helper(_I, _NumsArray, _MaxSuffixDp) ->
    0.