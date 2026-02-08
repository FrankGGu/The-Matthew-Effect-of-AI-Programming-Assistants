-module(solution).
-export([count_keys/1]).

count_keys(Keys) ->
    count_keys(Keys, 0, undefined).

count_keys([], _Count, _Prev) ->
    _Count;
count_keys([H | T], Count, Prev) ->
    case Prev of
        undefined ->
            count_keys(T, Count, H);
        _ ->
            if
                H /= Prev ->
                    count_keys(T, Count + 1, H);
                true ->
                    count_keys(T, Count, H)
            end
    end.