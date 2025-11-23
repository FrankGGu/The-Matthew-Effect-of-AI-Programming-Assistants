-module(solution).
-export([can_convert/2]).

can_convert(Str1, Str2) ->
    case length(Str1) =:= length(Str2) of
        false -> false;
        true ->
            Maps = maps:new(),
            check_mapping(Str1, Str2, Maps)
    end.

check_mapping([], [], _) -> true;
check_mapping([C1|Rest1], [C2|Rest2], Maps) ->
    case maps:find(C1, Maps) of
        {ok, C2} -> check_mapping(Rest1, Rest2, Maps);
        error ->
            case lists:member(C2, maps:values(Maps)) of
                true -> false;
                false -> check_mapping(Rest1, Rest2, maps:put(C1, C2, Maps))
            end
    end.