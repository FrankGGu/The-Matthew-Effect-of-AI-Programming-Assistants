-module(solution).
-export([str_transform/2]).

str_transform(S, T) ->
    str_transform(S, T, 0, 0, dict:new(), dict:new()).

str_transform([], [], _, _, _, _) ->
    true;
str_transform(_, [], _, _, _, _) ->
    false;
str_transform([], _, _, _, _, _) ->
    false;
str_transform([H1 | T1], [H2 | T2], I, J, D1, D2) ->
    case dict:is_key(H1, D1) of
        true ->
            case dict:fetch(H1, D1) of
                H2 ->
                    str_transform(T1, T2, I + 1, J + 1, D1, D2);
                _ ->
                    false
            end;
        false ->
            case dict:is_key(H2, D2) of
                true ->
                    case dict:fetch(H2, D2) of
                        H1 ->
                            str_transform(T1, T2, I + 1, J + 1, D1, D2);
                        _ ->
                            false
                    end;
                false ->
                    dict:store(H1, H2, D1),
                    dict:store(H2, H1, D2),
                    str_transform(T1, T2, I + 1, J + 1, D1, D2)
            end
    end.