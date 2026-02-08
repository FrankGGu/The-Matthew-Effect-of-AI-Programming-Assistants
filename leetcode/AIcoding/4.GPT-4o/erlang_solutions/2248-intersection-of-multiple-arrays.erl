-module(solution).
-export([intersection/1]).

intersection(Arrays) ->
    case Arrays of
        [] -> [];
        [H | T] -> lists:foldl(fun(A, Acc) -> lists:filter(fun(X) -> lists:member(X, A) end, Acc) end, H, T)
    end.