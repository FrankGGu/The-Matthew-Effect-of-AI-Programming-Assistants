-module(solution).
-export([remove_stars/1]).

remove_stars(String) ->
    remove_stars(String, []).

remove_stars([], Acc) ->
    lists:reverse(Acc);
remove_stars([H | T], Acc) ->
    case H of
        $* -> 
            case Acc of
                [] -> remove_stars(T, Acc);
                [_ | Rest] -> remove_stars(T, Rest)
            end;
        _ -> 
            remove_stars(T, [H | Acc])
    end.