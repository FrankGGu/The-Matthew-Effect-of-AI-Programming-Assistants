-module(solution).
-export([find_lu_slength/2]).

-spec find_lu_slength(string(), string()) -> integer().
find_lu_slength(A, B) ->
    case A =:= B of
        true -> -1;
        false -> max:length(A), length(B)
    end.
