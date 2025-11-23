-module(solution).
-export([add_operators/2]).

add_operators(Num, Target) ->
    add_operators(Num, Target, 0, [], []).

add_operators([], _, _, _, Acc) ->
    lists:reverse(Acc);
add_operators(Num, Target, Index, Path, Acc) ->
    case Index of
        _ when Index == length(Num) ->
            case eval(Path) of
                Target -> [lists:flatten(Path) | Acc];
                _ -> Acc
            end;
        _ ->
            lists:foldl(fun(I, Acc1) ->
                            if I > Index + 1, Index == 0 -> Acc1;
                               true ->
                                    case lists:sublist(Num, Index + 1, I - Index) of
                                        "0" ++ _ -> Acc1;
                                        _ ->
                                            NewPath = case Path of
                                                          [] -> lists:sublist(Num, Index + 1, I - Index);
                                                          _ -> Path ++ [lists:sublist(Num, Index + 1, I - Index)]
                                                      end,
                                            add_operators(Num, Target, I, NewPath, Acc1)
                                    end
                            end
                        end, Acc, lists:seq(Index + 1, length(Num))).

eval([]) -> 0;
eval([H | T]) ->
    eval(H, T, 0, 0, 0).

eval(_, [], Current, Prev, Acc) ->
    Acc + Current * Prev;
eval(Op, [H | T], Current, Prev, Acc) ->
    case Op of
        '+' -> eval(H, T, Current + Prev, 0, Acc);
        '-' -> eval(H, T, Current - Prev, 0, Acc);
        '*' -> eval(H, T, Current, Prev * H, Acc)
    end.

eval(H, T, Current, Prev, Acc) ->
    eval('+', T, H, 0, Acc).