-module(isomorphic_strings).
-export([is_isomorphic/2]).

is_isomorphic(S, T) ->
    is_isomorphic(S, T, #{}, #{}).

is_isomorphic([], [], _Map1, _Map2) ->
    true;
is_isomorphic([H1|T1], [H2|T2], Map1, Map2) ->
    case maps:find(H1, Map1) of
        {ok, H2} ->
            is_isomorphic(T1, T2, Map1, Map2);
        error ->
            case maps:find(H2, Map2) of
                {ok, H1} ->
                    is_isomorphic(T1, T2, maps:put(H1, H2, Map1), maps:put(H2, H1, Map2));
                error ->
                    is_isomorphic(T1, T2, maps:put(H1, H2, Map1), maps:put(H2, H1, Map2))
            end
    end;
is_isomorphic(_, _, _, _) ->
    false.