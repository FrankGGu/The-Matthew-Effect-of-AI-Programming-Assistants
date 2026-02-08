-module(solution).
-export([canTransform/2]).

canTransform(Str1, Str2) ->
    Len1 = length(Str1),
    Len2 = length(Str2),

    if Len1 =/= Len2 ->
        false;
       true ->
        if Str1 == Str2 ->
            true;
           true ->
            InitialMap = #{},
            InitialSeenChars = sets:new(),

            case check_isomorphic(Str1, Str2, InitialMap, InitialSeenChars) of
                {ok, FinalSeenChars} ->
                    sets:size(FinalSeenChars) < 26;
                false ->
                    false
            end
        end
    end.

check_isomorphic([], [], _Map, SeenChars) ->
    {ok, SeenChars};
check_isomorphic([C1 | Rest1], [C2 | Rest2], Map, SeenChars) ->
    case maps:find(C1, Map) of
        {ok, MappedC2} ->
            if MappedC2 == C2 ->
                check_isomorphic(Rest1, Rest2, Map, SeenChars);
               true ->
                false
            end;
        error ->
            NewMap = maps:put(C1, C2, Map),
            NewSeenChars = sets:add_element(C2, SeenChars),
            check_isomorphic(Rest1, Rest2, NewMap, NewSeenChars)
    end;
check_isomorphic(_, _, _, _) ->
    false.