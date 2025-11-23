-module(solution).
-export([maximize_score/1]).

-include_lib("array/include/array.hrl").

maximize_score(Nums) ->
    N = length(Nums),
    PxorList = prefix_xors(Nums),
    PxorArray = array:from_list(PxorList),

    maximize_score_outer_loop(0, N, PxorArray, 0).

prefix_xors(Nums) ->
    lists:reverse(lists:foldl(fun(X, Acc) -> [hd(Acc) bxor X | Acc] end, [0], Nums)).

maximize_score_outer_loop(I, N, PxorArray, MaxScore) when I < N ->
    maximize_score_inner_loop(I, I, N, PxorArray, MaxScore);
maximize_score_outer_loop(N, N, _PxorArray, MaxScore) ->
    MaxScore.

maximize_score_inner_loop(I, J, N, PxorArray, MaxScore) when J < N ->
    CurrentXorSum = (array:get(J + 1, PxorArray)) bxor (array:get(I, PxorArray)),
    CurrentLength = J - I + 1,
    CurrentScore = CurrentXorSum + CurrentLength,
    NewMaxScore = max(MaxScore, CurrentScore),
    maximize_score_inner_loop(I, J + 1, N, PxorArray, NewMaxScore);
maximize_score_inner_loop(I, N, N, PxorArray, MaxScore) ->
    maximize_score_outer_loop(I + 1, N, PxorArray, MaxScore).