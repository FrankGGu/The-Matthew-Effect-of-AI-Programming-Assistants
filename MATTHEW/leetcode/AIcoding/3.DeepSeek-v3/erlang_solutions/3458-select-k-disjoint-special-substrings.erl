-module(solution).
-export([select_k_disjoint_substrings/3]).

select_k_disjoint_substrings(S, K, C) ->
    N = length(S),
    case K of
        0 -> 1;
        _ ->
            case N < K of
                true -> 0;
                false ->
                    case S of
                        [] -> 0;
                        _ ->
                            FirstChar = hd(S),
                            case FirstChar =:= C of
                                true ->
                                    case tl(S) of
                                        [] ->
                                            select_k_disjoint_substrings([], K - 1, C);
                                        Rest ->
                                            select_k_disjoint_substrings(Rest, K - 1, C) +
                                            select_k_disjoint_substrings(Rest, K, C)
                                    end;
                                false ->
                                    select_k_disjoint_substrings(tl(S), K, C)
                            end
                    end
            end
    end.