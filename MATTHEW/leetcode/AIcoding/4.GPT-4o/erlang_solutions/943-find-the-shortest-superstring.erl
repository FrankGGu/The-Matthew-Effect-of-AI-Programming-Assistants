-module(solution).
-export([find_shortest_superstring/1]).

find_shortest_superstring(Strs) ->
    case length(Strs) of
        0 -> "";
        1 -> hd(Strs);
        _ -> find_shortest_superstring(Strs, [], 0)
    end.

find_shortest_superstring([], Res, _) ->
    lists:flatten(lists:reverse(Res));
find_shortest_superstring(Strs, Res, _) ->
    lists:foldl(fun(Str, Acc) ->
        find_shortest_superstring([Str | Acc], Res, length(Res))
    end, Strs, []).

find_shortest_superstring([H | T], Res, L) ->
    NewRes = [H | Res],
    NewL = length(hd(NewRes)),
    case T of
        [] -> find_shortest_superstring([], NewRes, NewL);
        _ -> 
            lists:foldl(fun(X, Acc) ->
                NewSuperstring = merge_strings(H, X),
                case NewSuperstring of
                    "" -> Acc;
                    _ -> 
                        case length(NewSuperstring) < L of
                            true -> find_shortest_superstring(T, [NewSuperstring | Res], length(NewSuperstring));
                            false -> Acc
                        end
                end
            end, [], T)
    end.

merge_strings(A, B) ->
    {LenA, LenB} = {length(A), length(B)},
    MaxOverlap = lists:max([overlap(A, B, I) || I <- lists:seq(0, LenA)]),
    if MaxOverlap > 0 ->
        lists:concat([A, lists:sublist(B, MaxOverlap)]);
    true ->
        A ++ B
    end.

overlap(A, B, I) ->
    case lists:sublist(A, I) of
        [] -> 0;
        SubA -> 
            case lists:prefix(B, SubA) of
                true -> length(SubA);
                false -> overlap(A, B, I + 1)
            end
    end.