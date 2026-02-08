-module(solution).
-export([num_music_playlists/3]).

num_music_playlists( N, K, L ) ->
    DP = array:new( [ {size, L+1}, {default, 0} ] ),
    array:set(0, 1, DP),
    lists:foldl( fun(I, Acc) ->
        NewAcc = array:new( [ {size, L+1}, {default, 0} ] ),
        lists:foreach( fun(J) ->
            Val = array:get(J, Acc),
            if Val > 0 ->
                array:set(J, array:get(J, NewAcc) + Val * (N - J), NewAcc);
            true -> ok
            end,
            if Val > 0 andalso J >= K ->
                array:set(J-1, array:get(J-1, NewAcc) + Val * (J - K), NewAcc);
            true -> ok
            end
        end, lists:seq(0, L) ),
        NewAcc
    end, DP, lists:seq(1, L) ),
    array:get(L, array:get(L, array:new( [ {size, L+1}, {default, 0} ] ))).

array_get(Arr, Index) ->
    array:get(Index, Arr).