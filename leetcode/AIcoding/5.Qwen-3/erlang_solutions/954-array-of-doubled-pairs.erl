-module(doubled_pairs).
-export([can_be_arranged/1]).

can_be_arranged(A) ->
    can_be_arranged(A, maps:new()).

can_be_arranged([], _) ->
    true;
can_be_arranged([H | T], Count) ->
    case maps:get(H, Count, 0) of
        0 ->
            case maps:get(H * 2, Count, 0) of
                0 ->
                    maps:put(H, 1, Count),
                    can_be_arranged(T, Count);
                _ ->
                    maps:put(H, 1, Count),
                    maps:put(H * 2, maps:get(H * 2, Count) - 1, Count),
                    can_be_arranged(T, Count)
            end;
        _ ->
            maps:put(H, maps:get(H, Count) - 1, Count),
            maps:put(H * 2, maps:get(H * 2, Count, 0) + 1, Count),
            can_be_arranged(T, Count)
    end.