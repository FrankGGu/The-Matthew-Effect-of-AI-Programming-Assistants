-module(solution).
-export([find_almost_equal/2]).

find_almost_equal(S, T) ->
    find_almost_equal(S, T, 0).

find_almost_equal(S, T, Pos) ->
    case string:substr(S, Pos+1, length(T)) of
        T ->
            Pos;
        _ ->
            case Pos + 1 of
                Len when Len >= length(S) ->
                    -1;
                _ ->
                    find_almost_equal(S, T, Pos + 1)
            end
    end.