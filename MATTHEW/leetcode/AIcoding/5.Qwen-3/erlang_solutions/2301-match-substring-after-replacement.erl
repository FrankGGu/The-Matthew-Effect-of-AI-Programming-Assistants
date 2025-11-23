-module(solution).
-export([match_replacement/2]).

match_replacement(S, P) ->
    match_replacement(S, P, 0).

match_replacement(S, P, Index) ->
    case Index of
        Len when Len =:= length(P) ->
            true;
        _ ->
            case string:at(P, Index) of
                $* ->
                    case Index + 1 of
                        Next when Next =:= length(P) ->
                            true;
                        _ ->
                            lists:any(fun(I) -> match_replacement(S, P, Index + 1) end, lists:seq(Index, length(S)))
                    end;
                _ ->
                    case S of
                        [] ->
                            false;
                        [C | T] ->
                            case string:at(P, Index) of
                                C ->
                                    match_replacement(T, P, Index + 1);
                                _ ->
                                    false
                            end
                    end
            end
    end.