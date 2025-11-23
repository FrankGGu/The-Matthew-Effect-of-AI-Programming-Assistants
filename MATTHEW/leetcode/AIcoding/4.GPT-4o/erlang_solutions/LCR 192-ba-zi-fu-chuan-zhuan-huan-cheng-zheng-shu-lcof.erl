-module(solution).
-export([my_atoi/1]).

my_atoi(Str) ->
    Trimmed = string:trim(Str),
    case Trimmed of
        [] -> 0;
        _ ->
            {Sign, Rest} = case string:to_integer(Trimmed) of
                {ok, Num} -> {1, Num};
                _ ->
                    case lists:prefix(Trimmed, "-") of
                        true -> {-1, string:substr(Trimmed, 2)};
                        false -> {1, case lists:prefix(Trimmed, "+") of
                                         true -> string:substr(Trimmed, 2);
                                         false -> Trimmed
                                     end}
                    end
            end,
            case string:to_integer(Rest) of
                {ok, Num} -> 
                    case Sign * Num of
                        Result when Result < -2147483648 -> -2147483648;
                        Result when Result > 2147483647 -> 2147483647;
                        Result -> Result
                    end;
                _ -> 0
            end
    end.