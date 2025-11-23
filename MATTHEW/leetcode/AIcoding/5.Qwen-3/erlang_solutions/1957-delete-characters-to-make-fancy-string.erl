-module(delete_characters_to_make_fancy_string).
-export([make_fancy_string/1]).

make_fancy_string(S) ->
    make_fancy_string(S, [], 0).

make_fancy_string([], Acc, _) ->
    lists:reverse(Acc);
make_fancy_string([C | T], Acc, Count) ->
    case Acc of
        [] ->
            make_fancy_string(T, [C | Acc], 1);
        [H | _] when H == C ->
            if
                Count < 2 ->
                    make_fancy_string(T, [C | Acc], Count + 1);
                true ->
                    make_fancy_string(T, Acc, 0)
            end;
        _ ->
            make_fancy_string(T, [C | Acc], 1)
    end.