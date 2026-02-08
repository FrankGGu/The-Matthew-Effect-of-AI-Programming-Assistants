-module(solution).
-export([get_max_repetitions/4]).

get_max_repetitions(S1, N1, S2, N2) ->
    S1List = unicode:characters_to_list(S1),
    S2List = unicode:characters_to_list(S2),
    Len1 = length(S1List),
    Len2 = length(S2List),
    {Rep, K} = find_pattern(S1List, N1, S2List, Len1, Len2),
    (Rep * N1 + K) div (N2 * Len2).

find_pattern(S1, N1, S2, Len1, Len2) ->
    find_pattern(S1, N1, S2, Len1, Len2, 0, 0, 0, #{}).

find_pattern(_, N1, _, _, Len2, K, Rep, _, _) when K >= N1 * Len2 ->
    {Rep, K};
find_pattern(S1, N1, S2, Len1, Len2, K, Rep, Pos, Mem) ->
    case maps:find(Pos, Mem) of
        {ok, {OldK, OldRep}} ->
            LoopLen = K - OldK,
            LoopRep = Rep - OldRep,
            Loops = (N1 * Len2 - OldK) div LoopLen,
            NewK = OldK + Loops * LoopLen,
            NewRep = OldRep + Loops * LoopRep,
            find_pattern(S1, N1, S2, Len1, Len2, NewK, NewRep, Pos, Mem);
        error ->
            NewMem = maps:put(Pos, {K, Rep}, Mem),
            case lists:nth((Pos rem Len1) + 1, S1) =:= lists:nth((K rem Len2) + 1, S2) of
                true ->
                    NewPos = (Pos + 1) rem Len1,
                    NewK = K + 1,
                    NewRep = case NewPos of 0 -> Rep + 1; _ -> Rep end,
                    find_pattern(S1, N1, S2, Len1, Len2, NewK, NewRep, NewPos, NewMem);
                false ->
                    NewPos = (Pos + 1) rem Len1,
                    find_pattern(S1, N1, S2, Len1, Len2, K, Rep, NewPos, NewMem)
            end
    end.