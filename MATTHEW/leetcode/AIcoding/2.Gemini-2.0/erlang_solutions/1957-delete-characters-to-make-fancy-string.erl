-module(fancy_string).
-export([make_fancy_string/1]).

make_fancy_string(S) ->
    make_fancy_string(S, [], 0, $).

make_fancy_string([], Acc, _, _) ->
    lists:reverse(Acc);
make_fancy_string([H | T], Acc, Count, Prev) ->
    if
        H == Prev ->
            if
                Count < 2 ->
                    make_fancy_string(T, [H | Acc], Count + 1, H);
                true ->
                    make_fancy_string(T, Acc, Count, Prev)
            end;
        true ->
            make_fancy_string(T, [H | Acc], 1, H)
    end.