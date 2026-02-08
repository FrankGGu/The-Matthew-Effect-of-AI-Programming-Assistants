-module(solution).
-export([countTexts/1]).

-define(MOD, 1000000007).
-define(MAX_INPUT_LEN, 100000).

precompute_dp3(MaxK) ->
    DP3 = array:new([{size, MaxK + 1}, {fixed, true}]),
    DP3_1 = array:set(0, 1, DP3),
    DP3_2 = array:set(1, 1, DP3_1),
    DP3_3 = array:set(2, 2, DP3_2),
    fill_dp3_loop(3, MaxK, DP3_3).

fill_dp3_loop(K, MaxK, DP3) when K =< MaxK ->
    V = (array:get(K-1, DP3) + array:get(K-2, DP3) + array:get(K-3, DP3)) rem ?MOD,
    fill_dp3_loop(K+1, MaxK, array:set(K, V, DP3));
fill_dp3_loop(_, _, DP3) ->
    DP3.

precompute_dp4(MaxK) ->
    DP4 = array:new([{size, MaxK + 1}, {fixed, true}]),
    DP4_1 = array:set(0, 1, DP4),
    DP4_2 = array:set(1, 1, DP4_1),
    DP4_3 = array:set(2, 2, DP4_2),
    DP4_4 = array:set(3, 4, DP4_3),
    fill_dp4_loop(4, MaxK, DP4_4).

fill_dp4_loop(K, MaxK, DP4) when K =< MaxK ->
    V = (array:get(K-1, DP4) + array:get(K-2, DP4) + array:get(K-3, DP4) + array:get(K-4, DP4)) rem ?MOD,
    fill_dp4_loop(K+1, MaxK, array:set(K, V, DP4));
fill_dp4_loop(_, _, DP4) ->
    DP4.

countTexts(PressedKeys) ->
    DP3 = precompute_dp3(?MAX_INPUT_LEN),
    DP4 = precompute_dp4(?MAX_INPUT_LEN),

    String = binary_to_list(PressedKeys),
    count_segments(String, 1, DP3, DP4).

count_segments([], Acc, _, _) -> Acc;
count_segments([H|T], Acc, DP3, DP4) ->
    {SegmentLen, Rest} = find_segment_length([H|T], H, 0),
    WaysForSegment = get_ways(H, SegmentLen, DP3, DP4),
    NewAcc = (Acc * WaysForSegment) rem ?MOD,
    count_segments(Rest, NewAcc, DP3, DP4).

find_segment_length([Char|T], Char, Len) ->
    find_segment_length(T, Char, Len + 1);
find_segment_length(Rest, _, Len) ->
    {Len, Rest}.

get_ways(Char, Len, DP3, DP4) ->
    case Char of
        $7 -> array:get(Len, DP4);
        $9 -> array:get(Len, DP4);
        _  -> array:get(Len, DP3)
    end.