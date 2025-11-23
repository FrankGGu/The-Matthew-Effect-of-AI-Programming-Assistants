-module(solution).
-export([shift_distance/2]).

shift_distance(Str1, Str2) ->
    Length1 = string:length(Str1),
    Length2 = string:length(Str2),
    if
        Length1 /= Length2 ->
            -1;
        true ->
            lists:foldl(fun(X, Acc) -> 
                if
                    string:substr(Str1, 1, 1) =:= X ->
                        Acc + 1;
                    true ->
                        Acc
                end
            end, 0, string:to_list(Str2)) mod Length1
    end.