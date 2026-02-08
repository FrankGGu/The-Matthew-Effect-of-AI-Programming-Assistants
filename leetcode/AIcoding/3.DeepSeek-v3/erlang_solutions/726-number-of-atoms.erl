-module(solution).
-export([countOfAtoms/1]).

countOfAtoms(Formula) ->
    {Dict, _} = parse(Formula, 0, #{}),
    lists:concat([atom_to_list(Atom) ++ case Count of 1 -> ""; _ -> integer_to_list(Count) end || {Atom, Count} <- lists:keysort(1, maps:to_list(Dict))]).

parse([], _Pos, Dict) -> {Dict, []};
parse([$( | Rest], Pos, Dict) ->
    {NewDict, Rest1} = parse(Rest, Pos + 1, #{}),
    {Count, Rest2} = parse_count(Rest1),
    MergedDict = merge_dicts(Dict, NewDict, Count),
    parse(Rest2, Pos + 1, MergedDict);
parse([$) | Rest], Pos, Dict) ->
    {Dict, Rest};
parse([H | T], Pos, Dict) when H >= $A, H =< $Z ->
    {Atom, Rest} = parse_atom([H | T]),
    {Count, Rest1} = parse_count(Rest),
    NewDict = maps:put(Atom, maps:get(Atom, Dict, 0) + Count, Dict),
    parse(Rest1, Pos + 1, NewDict).

parse_atom([H | T]) when H >= $A, H =< $Z ->
    case T of
        [L | Rest] when L >= $a, L =< $z ->
            {list_to_atom([H, L]), Rest};
        _ ->
            {list_to_atom([H]), T}
    end.

parse_count(Str) ->
    parse_count(Str, 0).
parse_count([], Count) when Count == 0 -> {1, []};
parse_count([], Count) -> {Count, []};
parse_count([H | T], Count) when H >= $0, H =< $9 ->
    parse_count(T, Count * 10 + (H - $0));
parse_count(Str, Count) when Count == 0 -> {1, Str};
parse_count(Str, Count) -> {Count, Str}.

merge_dicts(Dict1, Dict2, Multiplier) ->
    maps:fold(fun(K, V, Acc) -> maps:put(K, maps:get(K, Acc, 0) + V * Multiplier, Acc) end, Dict1, Dict2).