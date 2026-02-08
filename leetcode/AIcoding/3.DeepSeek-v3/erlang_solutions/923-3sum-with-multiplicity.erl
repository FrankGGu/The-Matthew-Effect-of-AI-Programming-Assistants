-module(solution).
-export([three_sum_multi/3]).

three_sum_multi(Arr, Target, Mod) ->
    Counts = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end, #{}, Arr),
    Keys = lists:sort(maps:keys(Counts)),
    three_sum_multi(Keys, Counts, Target, Mod, 0).

three_sum_multi([], _, _, _, Acc) -> Acc;
three_sum_multi([X | Rest], Counts, Target, Mod, Acc) ->
    NewAcc = case 3 * X =:= Target of
        true -> 
            C = maps:get(X, Counts, 0),
            (Acc + C * (C - 1) * (C - 2) div 6) rem Mod;
        false -> Acc
    end,
    NewAcc1 = case maps:get(X, Counts, 0) >= 2 of
        true ->
            Y = Target - 2 * X,
            case Y > X andalso maps:is_key(Y, Counts) of
                true -> 
                    Cx = maps:get(X, Counts, 0),
                    Cy = maps:get(Y, Counts, 0),
                    (NewAcc + Cx * (Cx - 1) div 2 * Cy) rem Mod;
                false -> NewAcc
            end;
        false -> NewAcc
    end,
    {NewAcc2, _} = lists:foldl(fun(Y, {AccIn, Seen}) ->
        case Y > X of
            true ->
                Z = Target - X - Y,
                case Z > Y andalso maps:is_key(Z, Counts) of
                    true -> 
                        Cx = maps:get(X, Counts, 0),
                        Cy = maps:get(Y, Counts, 0),
                        Cz = maps:get(Z, Counts, 0),
                        {(AccIn + Cx * Cy * Cz) rem Mod, Seen};
                    false -> {AccIn, Seen}
                end;
            false -> {AccIn, Seen}
        end
    end, {NewAcc1, #{}}, Rest),
    three_sum_multi(Rest, Counts, Target, Mod, NewAcc2).