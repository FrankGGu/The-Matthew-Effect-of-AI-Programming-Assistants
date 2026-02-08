-module(swap_adjacent_in_lr_string).
-export([canTransform/1]).

canTransform(S) ->
    canTransform(S, [], []).

canTransform([], [], []) -> true;
canTransform([], Ls, Rs) when Ls /= [] -> false;
canTransform([], Ls, Rs) when Rs /= [] -> false;
canTransform([H | T], Ls, Rs) ->
    case H of
        $L ->
            canTransform(T, [H | Ls], Rs);
        $R ->
            canTransform(T, Ls, [H | Rs]);
        $X ->
            canTransform(T, Ls, Rs);
        _ ->
            case Ls of
                [L | _] when L == $L ->
                    case Rs of
                        [R | _] when R == $R ->
                            canTransform(T, Ls, Rs);
                        _ ->
                            canTransform(T, Ls, Rs)
                    end;
                _ ->
                    canTransform(T, Ls, Rs)
            end
    end.