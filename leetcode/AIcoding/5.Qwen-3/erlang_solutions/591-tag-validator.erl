-module(tag_validator).
-export([parse/1]).

parse(S) ->
    parse(S, []).

parse([], []) ->
    true;
parse([], _) ->
    false;
parse([$$ | T], []) ->
    parse(T, [<<"">>]);
parse([$$ | T], Stack) ->
    parse(T, [<<"">> | Stack]);
parse([$> | T], [Current | Rest]) ->
    case is_valid_tag(Current) of
        true ->
            parse(T, Rest);
        false ->
            false
    end;
parse([C | T], [Current | Rest]) ->
    case is_alpha(C) of
        true ->
            parse(T, [Current ++ [C] | Rest]);
        false ->
            case is_valid_tag(Current) of
                true ->
                    parse(T, [<<>> | Rest]);
                false ->
                    false
            end
    end.

is_valid_tag(<<>>) ->
    false;
is_valid_tag(Tag) ->
    is_alpha(Tag).

is_alpha(<<C, Rest/binary>>) when C >= $A, C =< $Z ->
    is_alpha(Rest);
is_alpha(<<C, Rest/binary>>) when C >= $a, C =< $z ->
    is_alpha(Rest);
is_alpha(<<>>) ->
    true;
is_alpha(_) ->
    false.