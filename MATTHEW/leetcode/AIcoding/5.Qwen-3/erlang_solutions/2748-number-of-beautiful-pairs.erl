-module(beautiful_pairs).
-export([num_beautiful_pairs/2]).

num_beautiful_pairs( nums, k ) ->
    Count = 0,
    Len = length(nums),
    lists:foldl( fun(I, Acc) ->
        lists:foldl( fun(J, Acc2) ->
            if I < J ->
                A = lists:nth(I+1, nums),
                B = lists:nth(J+1, nums),
                case (A rem k) == (B rem k) of
                    true -> Acc2 + 1;
                    false -> Acc2
                end;
            true -> Acc2
            end
        end, Acc, lists:seq(I+1, Len-1))
    end, Count, lists:seq(0, Len-2)).