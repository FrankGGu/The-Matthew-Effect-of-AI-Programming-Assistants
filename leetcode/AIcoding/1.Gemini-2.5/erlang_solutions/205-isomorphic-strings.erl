-module(solution).
-export([is_isomorphic/2]).

is_isomorphic(S, T) when length(S) =/= length(T) ->
    false;
is_isomorphic(S, T) ->
    check_isomorphic(lists:zip(S, T), #{}, #{}).

check_isomorphic([], _S_To_T_Map, _T_To_S_Map) ->
    true;
check_isomorphic([{CharS, CharT} | Rest], S_To_T_Map, T_To_S_Map) ->
    case maps:find(CharS, S_To_T_Map) of
        {ok, MappedCharT} ->
            if MappedCharT =:= CharT ->
                check_isomorphic(Rest, S_To_T_Map, T_To_S_Map);
            true ->
                false
            end;
        error -> % CharS not in S_To_T_Map
            case maps:find(CharT, T_To_S_Map) of
                {ok, _MappedCharS} -> % CharT is already mapped from another CharS'
                    false;
                error -> % CharT not in T_To_S_Map, establish new mapping
                    New_S_To_T_Map = maps:put(CharS, CharT, S_To_T_Map),
                    New_T_To_S_Map = maps:put(CharT, CharS, T_To_S_Map),
                    check_isomorphic(Rest, New_S_To_T_Map, New_T_To_S_Map)
            end
    end.