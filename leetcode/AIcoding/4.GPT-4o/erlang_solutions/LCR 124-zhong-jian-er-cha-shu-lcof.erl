-module(solution).
-export([solve/1]).

solve(Tree) ->
    case Tree of
        {nil, _} -> false;
        {Value, Left, Right} -> 
            case Value of
                1 -> solve(Left) orelse solve(Right);
                0 -> not (solve(Left) orelse solve(Right))
            end
    end.