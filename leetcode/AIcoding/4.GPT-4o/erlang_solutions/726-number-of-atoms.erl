-module(solution).
-export([countOfAtoms/1]).

countOfAtoms(Formula) ->
    FormulaList = string:to_list(Formula),
    {Atoms, _} = parse_formula(FormulaList, 0),
    AtomCounts = lists:foldl(fun({Atom, Count}, Acc) ->
        maps:update_with(Atom, fun(X) -> X + Count end, fun() -> Count end, Acc)
    end, #{} , Atoms),
    AtomCounts.

parse_formula([], _Count) -> {[], 1};
parse_formula([$_ | Rest], Count) -> parse_formula(Rest, Count);
parse_formula([C | Rest], Count) when C >= $A, C =< $Z ->
    {Atom, NextRest} = parse_atom([C | Rest]),
    {Atoms, Mult} = parse_formula(NextRest, Count),
    [{Atom, Mult * Count} | Atoms];
parse_formula([C | Rest], Count) when C >= $a, C =< $z ->
    {Atom, NextRest} = parse_atom([C | Rest]),
    {Atoms, Mult} = parse_formula(NextRest, Count),
    [{Atom, Mult * Count} | Atoms];
parse_formula([C | Rest], Count) when C >= $0, C =< $9 ->
    {Num, NextRest} = parse_number([C | Rest]),
    {Atoms, Mult} = parse_formula(NextRest, Num * Count),
    Atoms;
parse_formula([C | Rest], Count) when C == $'(' ->
    {Atoms, NextCount} = parse_formula(Rest, Count),
    {Atoms, NextCount};
parse_formula([C | Rest], Count) when C == $')' ->
    {Atoms, Count};
parse_formula([C | Rest], Count) ->
    parse_formula(Rest, Count).

parse_atom([C | Rest]) when C >= $A, C =< $Z ->
    {Atom, NextRest} = parse_atom([C | Rest], [$C]),
    {string:to_lower(atom_to_list(Atom)), NextRest};
parse_atom([C | Rest]) when C >= $a, C =< $z ->
    {Atom, NextRest} = parse_atom([C | Rest], [$C]),
    {string:to_lower(atom_to_list(Atom)), NextRest};
parse_atom(Rest, Acc) ->
    {list_to_atom(lists:reverse(Acc)), Rest}.

parse_number([C | Rest]) when C >= $0, C =< $9 ->
    {Num, NextRest} = parse_number(Rest, [C]),
    {list_to_integer(lists:reverse(Num)), NextRest};
parse_number(Rest, Acc) ->
    {lists:reverse(Acc), Rest}.