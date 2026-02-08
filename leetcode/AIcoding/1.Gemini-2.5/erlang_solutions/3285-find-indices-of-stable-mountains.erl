-module(solution).
-export([findStableMountains/1]).

findStableMountains(MountainsList) ->
    N = length(MountainsList),
    Mountains = array:from_list(MountainsList),
    find_stable_mountains_rec(0, N, Mountains, []).

find_stable_mountains_rec(I, N, Mountains, Acc) when I >= N - 2 ->
    lists:reverse(Acc);
find_stable_mountains_rec(I, N, Mountains, Acc) ->
    case array:get(I, Mountains) of
        0 ->
            if I + 1 < N ->
                case array:get(I+1, Mountains) of
                    1 ->
                        K = find_end_of_ones(I+1, N, Mountains),
                        if K < N, array:get(K, Mountains) == 0 ->
                            find_stable_mountains_rec(I+1, N, Mountains, [I | Acc]);
                            true ->
                                find_stable_mountains_rec(I+1, N, Mountains, Acc)
                        end;
                    _ ->
                        find_stable_mountains_rec(I+1, N, Mountains, Acc)
                end;
                true ->
                    find_stable_mountains_rec(I+1, N, Mountains, Acc)
            end;
        _ ->
            find_stable_mountains_rec(I+1, N, Mountains, Acc)
    end.

find_end_of_ones(K, N, Mountains) ->
    if K < N ->
        case array:get(K, Mountains) of
            1 -> find_end_of_ones(K+1, N, Mountains);
            _ -> K
        end;
        true -> K
    end.