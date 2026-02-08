-module(solution).
-export([remove_anagrams/1]).

remove_anagrams(Arr) ->
    lists:foldl(fun(X, Acc) ->
        Sorted = lists:sort(list_to_binary(X)),
        case Acc of
            [] -> [X];
            [H | _] = Head when H =:= Sorted -> Head;
            _ -> [X | Acc]
        end
    end, [], lists:reverse(Arr).