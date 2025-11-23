-module(solution).
-export([count_lattice_points/1]).

count_lattice_points(Circles) ->
    Points = sets:new(),
    lists:foreach(fun({X, Y, R}) ->
        X1 = X - R,
        X2 = X + R,
        Y1 = Y - R,
        Y2 = Y + R,
        lists:foreach(fun(Xi) ->
            lists:foreach(fun(Yi) ->
                if
                    (math:pow(Xi - X, 2) + math:pow(Yi - Y, 2)) < math:pow(R, 2) ->
                        Points1 = sets:add_element({Xi, Yi}, Points),
                        Points = Points1;
                    true ->
                        ok
                end
            end, lists:seq(Y1, Y2))
        end, lists:seq(X1, X2))
    end, Circles),
    sets:size(Points).