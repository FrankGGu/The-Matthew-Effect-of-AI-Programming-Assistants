-module(solution).
-export([sorted_array_to_bst/1]).

sorted_array_to_bst([]) ->
    nil;
sorted_array_to_bst(Nums) ->
    Len = length(Nums),
    MidIdx = Len div 2,
    {LeftList, Rest} = lists:split(MidIdx, Nums),
    MidVal = hd(Rest),
    RightList = tl(Rest),
    {MidVal, sorted_array_to_bst(LeftList), sorted_array_to_bst(RightList)}.