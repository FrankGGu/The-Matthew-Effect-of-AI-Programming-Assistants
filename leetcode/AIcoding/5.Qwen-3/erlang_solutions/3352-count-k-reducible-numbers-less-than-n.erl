-module(solution).
-export([k_reducible/2]).

k_reducible(N, K) ->
    Count = 0,
    k_reducible(N, K, 1, Count).

k_reducible(_, _, N, Count) when N >= N ->
    Count;
k_reducible(N, K, Current, Count) ->
    case is_k_reducible(Current, K) of
        true -> k_reducible(N, K, Current + 1, Count + 1);
        false -> k_reducible(N, K, Current + 1, Count)
    end.

is_k_reducible(Num, K) ->
    is_k_reducible(Num, K, 1).

is_k_reducible(Num, K, Div) when Div * Div > Num ->
    false;
is_k_reducible(Num, K, Div) ->
    case Num rem Div of
        0 ->
            if
                Div == K -> true;
                true ->
                    case is_k_reducible(Num, K, Div + 1) of
                        true -> true;
                        false ->
                            case is_k_reducible(Num div Div, K, 2) of
                                true -> true;
                                false -> is_k_reducible(Num, K, Div + 1)
                            end
                    end
            end;
        _ -> is_k_reducible(Num, K, Div + 1)
    end.