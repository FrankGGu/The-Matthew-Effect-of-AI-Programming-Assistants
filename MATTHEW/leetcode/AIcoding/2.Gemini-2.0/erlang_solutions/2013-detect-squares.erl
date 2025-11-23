-module(detect_squares).
-export([new/0, add/1, count/1]).

-record(state, {points = dict:new()}).

new() ->
    #state{}.

add({X, Y}, State) ->
    Points = State#state.points,
    NewPoints = dict:update({X, Y}, fun(V) -> V + 1 end, 1, Points),
    State#state{points = NewPoints}.

count({X, Y}, State) ->
    Points = State#state.points,
    count_squares(X, Y, Points, 0).

count_squares(X, Y, Points, Acc) ->
    dict:fold(fun({X1, Y1}, _, Acc0) ->
        if X1 == X orelse Y1 == Y then
            Acc0
        else
            Side := abs(X - X1),
            if Side /= abs(Y - Y1) then
                Acc0
            else
                if dict:is_key({X, Y1}, Points) andalso dict:is_key({X1, Y}, Points) then
                    Acc1 := dict:fetch({X, Y1}, Points) * dict:fetch({X1, Y}, Points);
                    Acc0 + dict:fetch({X1, Y1}, Points) * Acc1
                else
                    Acc0
                end
            end
        end
    end, Acc, Points).