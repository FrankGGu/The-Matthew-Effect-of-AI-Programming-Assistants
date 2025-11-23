-module(longest_common_subpath).
-export([longest_common_subpath/2]).

longest_common_subpath(Paths, K) ->
    lists:foldl(fun(Path, Acc) -> 
        case Acc of
            [] -> [Path];
            _ -> 
                lists:filter(fun(P) -> 
                    common_subpath(P, Path) /= [] 
                end, Acc)
        end
    end, [], Paths).

common_subpath(A, B) ->
    common_subpath(A, B, 0, 0, []).

common_subpath([], _, _, _, Acc) -> lists:reverse(Acc);
common_subpath(_, [], _, _, Acc) -> lists:reverse(Acc);
common_subpath([H|T1], [H|T2], I, J, Acc) ->
    common_subpath(T1, T2, I+1, J+1, [H|Acc]);
common_subpath([_|T1], [H|T2], I, J, Acc) ->
    common_subpath(T1, T2, 0, 0, []);
common_subpath([H|T1], [H|T2], I, J, Acc) ->
    common_subpath(T1, T2, I+1, J+1, [H|Acc]);
common_subpath([H1|T1], [H2|T2], I, J, Acc) ->
    if H1 == H2 -> common_subpath(T1, T2, I+1, J+1, [H1|Acc]);
       true -> common_subpath(T1, T2, 0, 0, [])
    end.