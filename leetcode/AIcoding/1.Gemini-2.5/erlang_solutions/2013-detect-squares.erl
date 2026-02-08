-module(detect_squares).
-export([new/0, add/2, count/2]).

-record(ds_state, {points = #{} :: #{integer() => #{integer() => integer()}}}).

new() ->
    #ds_state{}.

add([X, Y], #ds_state{points = Points}) ->
    YMap = maps:get(X, Points, #{}),
    Count = maps:get(Y, YMap, 0),
    NewYMap = maps:put(Y, Count + 1, YMap),
    NewPoints = maps:put(X, NewYMap, Points),
    #ds_state{points = NewPoints}.

count([X1, Y1], #ds_state{points = Points}) ->
    TotalSquares = 0,
    maps:fold(fun(X2, YMap2, Acc) ->
        maps:fold(fun(Y2, Count2, InnerAcc) ->
            if X1 == X2 orelse Y1 == Y2 ->
                InnerAcc;
            true ->
                Side = abs(X1 - X2),
                if Side == abs(Y1 - Y2) ->
                    YMap1 = maps:get(X1, Points, #{}),
                    Count3 = maps:get(Y2, YMap1, 0),

                    Count4 = maps:get(Y1, YMap2, 0),

                    InnerAcc + (Count2 * Count3 * Count4);
                true ->
                    InnerAcc
                end
            end
        end, InnerAcc, YMap2)
    end, TotalSquares, Points).