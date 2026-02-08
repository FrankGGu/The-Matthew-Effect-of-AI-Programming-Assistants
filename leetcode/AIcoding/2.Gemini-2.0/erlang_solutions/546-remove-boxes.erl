-module(remove_boxes).
-export([remove_boxes/1]).

remove_boxes(Boxes) ->
    N = length(Boxes),
    Memo = array:new([N+1, N+1, N+1], undefined),
    remove_boxes_helper(Boxes, 0, N-1, 0, Memo).

remove_boxes_helper(Boxes, L, R, K, Memo) ->
    case array:get([L, R, K], Memo) of
        undefined ->
            Result = calculate_remove_boxes(Boxes, L, R, K, Memo),
            array:set([L, R, K], Result, Memo),
            Result;
        Value ->
            Value
    end.

calculate_remove_boxes(Boxes, L, R, K, Memo) ->
    if L > R then
        0
    else
        NL = L;
        NR = R;
        NK = K;

        while NL < NR andalso lists:nth(NL+1, Boxes) == lists:nth(NL, Boxes) do
            NL = NL + 1,
            NK = NK + 1
        end,

        Result1 = remove_boxes_helper(Boxes, NL + 1, NR, 0, Memo) + (NK + 1) * (NK + 1),
        Result2 = lists:foldl(fun(I, Acc) ->
                                     if I > NL andalso lists:nth(I, Boxes) == lists:nth(NL, Boxes) then
                                         max(Acc, remove_boxes_helper(Boxes, NL + 1, I - 1, 0, Memo) + remove_boxes_helper(Boxes, I, NR, NK + 1, Memo))
                                     else
                                         Acc
                                     end
                                 end, 0, lists:seq(NL + 1, NR)),
        max(Result1, Result2)
    end.