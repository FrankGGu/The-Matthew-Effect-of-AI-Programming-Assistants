-module(split_array_largest_sum).
-export([split_array/2]).

split_array(Nums, M) ->
    Left = lists:min(Nums),
    Right = lists:sum(Nums),
    binary_search(Nums, M, Left, Right).

binary_search(Nums, M, Left, Right) when Left < Right ->
    Mid = (Left + Right) div 2,
    case can_split(Nums, M, Mid) of
        true -> binary_search(Nums, M, Left, Mid);
        false -> binary_search(Nums, M, Mid + 1, Right)
    end;
binary_search(_, _, Left, _) ->
    Left.

can_split([], _M, _Max) ->
    true;
can_split(Nums, M, Max) ->
    Count = 1,
    CurrentSum = 0,
    can_split(Nums, M, Max, CurrentSum, Count).

can_split([], M, _Max, _CurrentSum, Count) when Count =< M ->
    true;
can_split([], _M, _Max, _CurrentSum, _Count) ->
    false;
can_split([H | T], M, Max, CurrentSum, Count) when CurrentSum + H > Max ->
    can_split(T, M, Max, H, Count + 1);
can_split([H | T], M, Max, CurrentSum, Count) ->
    can_split(T, M, Max, CurrentSum + H, Count).