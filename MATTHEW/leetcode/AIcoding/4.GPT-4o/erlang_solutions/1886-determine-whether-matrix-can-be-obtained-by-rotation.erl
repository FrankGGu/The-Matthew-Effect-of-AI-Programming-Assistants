-module(solution).
-export([find_rotation/2]).

find_rotation(Matrix, Target) ->
    case rotate(Matrix) of
        Target -> true;
        _ -> case rotate(rotate(Matrix)) of
            Target -> true;
            _ -> case rotate(rotate(rotate(Matrix))) of
                Target -> true;
                _ -> false
            end
        end
    end.

rotate(Matrix) ->
    lists:map(fun(I) -> lists:reverse(lists:nth(I, Matrix)) end, lists:seq(1, length(Matrix))).