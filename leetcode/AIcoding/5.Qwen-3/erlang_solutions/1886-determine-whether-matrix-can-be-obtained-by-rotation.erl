-module(solution).
-export([find_rotation/2]).

find_rotation(Matrix, Target) ->
    case rotate_matrix(Matrix) of
        Target -> true;
        _ -> 
            case rotate_matrix(rotate_matrix(Matrix)) of
                Target -> true;
                _ -> 
                    case rotate_matrix(rotate_matrix(rotate_matrix(Matrix))) of
                        Target -> true;
                        _ -> false
                    end
            end
    end.

rotate_matrix(Matrix) ->
    lists:reverse(lists:zipwith(fun lists:reverse/1, Matrix)).