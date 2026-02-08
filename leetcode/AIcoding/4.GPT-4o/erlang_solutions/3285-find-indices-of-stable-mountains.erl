-module(solution).
-export([find_stable_mountains/1]).

find_stable_mountains(Heights) ->
    stable_mountains(Heights, [], length(Heights)).

stable_mountains([], Acc, _) -> 
    lists:reverse(Acc);
stable_mountains([H | T], Acc, Length) ->
    case is_stable_mountain(H, T, Length) of
        true -> stable_mountains(T, [Length - length(T) - 1 | Acc], Length);
        false -> stable_mountains(T, Acc, Length)
    end.

is_stable_mountain(H, T, Index) ->
    case T of
        [] -> false;
        [H1 | _] when H1 >= H -> false;
        [H1 | Rest] ->
            case is_stable_mountain(H1, Rest, Index) of
                true -> false;
                false -> 
                    case Rest of
                        [] -> true;
                        [H2 | _] when H2 < H -> true;
                        _ -> false
                    end
            end
    end.