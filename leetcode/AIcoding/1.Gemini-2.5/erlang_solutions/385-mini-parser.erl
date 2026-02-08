-module(solution).
-export([deserialize/1]).

deserialize(S) ->
    Chars = string:to_list(S),
    {NestedInteger, _RemainingChars} = parse_nested(Chars),
    NestedInteger.

parse_nested([$[ | Rest]) ->
    parse_list_elements(Rest, []);
parse_nested(Chars) ->
    {IntChars, RemainingAfterInt} = parse_integer_string(Chars, []),
    {integer, list_to_integer(IntChars)}, RemainingAfterInt.

parse_list_elements([$] | Rest], Acc) ->
    {lists:reverse(Acc), Rest};
parse_list_elements([$, | Rest], Acc) ->
    parse_list_elements(Rest, Acc);
parse_list_elements(Chars, Acc) ->
    {Element, RemainingAfterElement} = parse_nested(Chars),
    parse_list_elements(RemainingAfterElement, [Element | Acc]).

parse_integer_string([C | Rest], Acc) when C >= $0, C =< $9 ->
    parse_integer_string(Rest, [C | Acc]);
parse_integer_string([$- | Rest], Acc) ->
    parse_integer_string(Rest, [$- | Acc]);
parse_integer_string(Chars, Acc) ->
    {lists:reverse(Acc), Chars}.