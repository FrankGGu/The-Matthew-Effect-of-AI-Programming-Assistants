-module(solution).
-export([find_replace_string/3]).

find_replace_string(S, Indices, Sources) ->
    find_replace_string(S, Indices, Sources, 0, []).

find_replace_string(_, [], _, _, Acc) ->
    lists:reverse(Acc);
find_replace_string(S, [I|Is], [Src|Ss], Pos, Acc) ->
    case Pos < I of
        true ->
            Acc1 = [string:substr(S, Pos+1, I - Pos) | Acc],
            find_replace_string(S, Is, Ss, I, Acc1);
        false ->
            case string:substr(S, I+1, length(Src)) == Src of
                true ->
                    Acc1 = [string:substr(S, Pos+1, I - Pos) ++ string:substr(S, I+1 + length(Src) - 1) | Acc],
                    find_replace_string(S, Is, Ss, I + length(Src), Acc1);
                false ->
                    Acc1 = [string:substr(S, Pos+1, I - Pos) | Acc],
                    find_replace_string(S, Is, Ss, I, Acc1)
            end
    end.