-module(number_of_atoms).
-export([count_atoms/1]).

count_atoms(formula) ->
    {Atoms, _} = parse(formula, 1),
    SortedAtoms = lists:sort(fun({A1, _}, {A2, _}) -> A1 < A2 end, maps:to_list(Atoms)),
    string:join([Atom ++ integer_to_list(Count) || {Atom, Count} <- SortedAtoms, Count > 1], "") ++
    string:join([Atom || {Atom, Count} <- SortedAtoms, Count == 1], "").

parse(String, Index) ->
    parse(String, Index, #{}).

parse(String, Index, Acc) ->
    case string:next_char(String, Index) of
        {done, _} ->
            {Acc, Index};
        {error, _} ->
            {Acc, Index};
        {valid, {$(, NextIndex}} ->
            {SubAtoms, NewIndex} = parse(String, NextIndex, #{}),
            {NewIndex2, Count} = get_count(String, NewIndex),
            MergedAtoms = merge_atoms(Acc, scale_atoms(SubAtoms, Count)),
            parse(String, NewIndex2, MergedAtoms);
        {valid, {$), NextIndex}} ->
            {Acc, NextIndex};
        {valid, {Char, NextIndex}} when Char >= $A, Char =< $Z ->
            {Atom, NewIndex} = get_atom(String, Index),
            {NewIndex2, Count} = get_count(String, NewIndex),
            NewAcc = maps:update_with(Atom, fun(V) -> V + Count end, Count, Acc),
            parse(String, NewIndex2, NewAcc);
        {valid, _, _} ->
            {Acc, Index}
    end.

get_atom(String, Index) ->
    get_atom(String, Index, []).

get_atom(String, Index, Acc) ->
    case string:next_char(String, Index) of
        {valid, {Char, NextIndex}} when Char >= $A, Char =< $Z ->
            get_atom(String, NextIndex, [Char | Acc]);
        {valid, {Char, NextIndex}} when Char >= $a, Char =< $z ->
            get_atom(String, NextIndex, [Char | Acc]);
        _ ->
            {lists:reverse(Acc), Index}
    end.

get_count(String, Index) ->
    get_count(String, Index, []).

get_count(String, Index, Acc) ->
    case string:next_char(String, Index) of
        {valid, {Char, NextIndex}} when Char >= $0, Char =< $9 ->
            get_count(String, NextIndex, [Char | Acc]);
        _ ->
            case lists:reverse(Acc) of
                [] ->
                    {Index, 1};
                Digits ->
                    {Index, list_to_integer(Digits)}
            end
    end.

list_to_integer(Digits) ->
    list_to_integer(Digits, 0).

list_to_integer([], Acc) ->
    Acc;
list_to_integer([Digit | Rest], Acc) ->
    list_to_integer(Rest, Acc * 10 + (Digit - $0)).

scale_atoms(Atoms, Count) ->
    maps:map(fun(_, V) -> V * Count end, Atoms).

merge_atoms(Atoms1, Atoms2) ->
    maps:fold(fun(Atom, Count, Acc) ->
                      maps:update_with(Atom, fun(V) -> V + Count end, Count, Acc)
              end, Atoms1, Atoms2).