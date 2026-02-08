-module(detect_squares).
-export([new/0, add/2, count/1]).

new() ->
    {dict:new(), dict:new()}.

add({X, Y}, State) ->
    {Points, XToYs} = State,
    NewPoints = dict:store({X, Y}, dict:fetch({X, Y}, Points, 0) + 1, Points),
    NewXToYs = dict:store(X, dict:store(Y, dict:fetch({X, Y}, XToYs, 0) + 1, dict:fetch(X, XToYs, dict:new())), XToYs),
    {NewPoints, NewXToYs}.

count({X, Y}, State) ->
    {Points, XToYs} = State,
    case dict:is_key(X, XToYs) of
        true ->
            Ys = dict:fetch(X, XToYs),
            lists:foldl(fun(Y1, Acc) ->
                            if Y1 == Y -> Acc;
                               true ->
                                    case dict:is_key(Y1, XToYs) of
                                        true ->
                                            Ys2 = dict:fetch(Y1, XToYs),
                                            lists:foldl(fun(Y2, Acc2) ->
                                                            if Y2 == Y -> Acc2;
                                                               true ->
                                                                    Count = dict:fetch({X, Y}, Points, 0) *
                                                                            dict:fetch({X, Y1}, Points, 0) *
                                                                            dict:fetch({Y1, Y2}, Points, 0) *
                                                                            dict:fetch({X, Y2}, Points, 0),
                                                                    Acc2 + Count
                                                            end
                                                        end, Acc, Ys2)
                                        false -> Acc
                                    end
                            end
                        end, 0, dict:keys(Ys));
        false -> 0
    end.

count(State) ->
    count({0, 0}, State).