-module(solution).
-export([find_restaurant/2]).

find_restaurant(List1, List2) ->
    Maps1 = lists:foldl(fun(X, Acc) -> maps:put(X, lists:index(X, List1), Acc) end, #{}, List1),
    lists:foldl(fun(X, Acc) ->
        case maps:find(X, Maps1) of
            {ok, Index1} ->
                Index2 = lists:index(X, List2),
                Sum = Index1 + Index2,
                case maps:find(Sum, Acc) of
                    {ok, R} -> 
                        case lists:member(X, R) of
                            true -> Acc;
                            false -> maps:put(Sum, [X | R], Acc)
                        end;
                    _ -> maps:put(Sum, [X], Acc)
                end;
            _ -> Acc
        end
    end, #{}, List2),
    case maps:fold(fun(_, V, Acc) -> lists:append(Acc, V) end, [], Maps1) of
        [] -> [];
        Result -> lists:sort(Result)
    end.