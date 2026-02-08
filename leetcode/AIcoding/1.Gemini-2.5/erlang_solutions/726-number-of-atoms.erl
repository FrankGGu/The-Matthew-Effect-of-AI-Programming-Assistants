-module(solution).
-export([countOfAtoms/1]).

countOfAtoms(Formula) ->
    Chars = unicode:characters_to_list(Formula),
    % Initial call: Index starts at 1, Stack is empty, CurrentCounts is an empty map for the top-level scope
    {FinalCounts, _} = parse(Chars, 1, [], #{}),

    SortedAtoms = lists:sort(maps:to_list(FinalCounts)),

    lists:foldl(
        fun({Atom, Count}, Acc) ->
            Acc ++ binary_to_list(Atom) ++ (
                case Count of
                    1 -> ""; % Don't print "1" if count is 1
                    _ -> integer_to_list(Count)
                end
            )
        end,
        "",
        SortedAtoms
    ).

parse(Chars, Index, Stack, CurrentCounts) ->
    Len = length(Chars),
    if
        Index > Len ->
            {CurrentCounts, Index}; % Reached end of string for this scope
        true ->
            Char = lists:nth(Index, Chars),
            if
                Char == $( ->
                    % When '(', we start a new sub-formula.
                    % Push the current scope's counts onto the stack.
                    % Start parsing the sub-formula with an empty map for its counts.
                    {SubCounts, SubEndIndex} = parse(Chars, Index + 1, [CurrentCounts | Stack], #{}),

                    % After the sub-formula returns (meaning we've processed up to and including the matching ')'),
                    % read the multiplier that might follow the ')'
                    {Multiplier, NextIndexAfterParen} = read_number(Chars, SubEndIndex + 1),

                    % Apply the multiplier to the counts obtained from the sub-formula
                    MultipliedSubCounts = multiply_counts(SubCounts, Multiplier),

                    % Merge these multiplied counts into the counts of the *current* scope.
                    % 'CurrentCounts' in this context refers to the map that existed before the '('.
                    MergedCounts = merge_counts(CurrentCounts, MultipliedSubCounts),

                    % Continue parsing the rest of the current scope from 'NextIndexAfterParen'
                    parse(Chars, NextIndexAfterParen, Stack, MergedCounts);

                Char == $) ->
                    % When ')', the current sub-formula is complete.
                    % Return its accumulated counts and the current index (pointing to ')')
                    % The calling 'parse' (which encountered '(') will handle the multiplier and merging.
                    {CurrentCounts, Index};

                is_capital(Char) ->
                    % When an atom starts (capital letter)
                    {AtomName, AtomEndIndex} = read_atom_name(Chars, Index),
                    {Count, NextIndex} = read_number(Chars, AtomEndIndex),

                    % Update the current scope's counts with this atom and its count
                    NewCurrentCounts = maps:update_with(AtomName, fun(OldCount) -> OldCount + Count end, Count, CurrentCounts),

                    % Continue parsing the current scope
                    parse(Chars, NextIndex, Stack, NewCurrentCounts);

                true -> % This case should ideally not be reached with valid input
                    error({invalid_char, Char, Index})
            end
    end.

read_atom_name(Chars, Index) ->
    read_atom_name_acc(Chars, Index, []).

read_atom_name_acc(Chars, Index, Acc) ->
    Len = length(Chars),
    if
        Index > Len -> % Reached end of string
            {list_to_binary(lists:reverse(Acc)), Index};
        true ->
            Char = lists:nth(Index, Chars),
            if
                is_capital(Char) andalso Acc == [] -> % First char of atom name must be capital
                    read_atom_name_acc(Chars, Index + 1, [Char | Acc]);
                is_lowercase(Char) -> % Subsequent chars can be lowercase
                    read_atom_name_acc(Chars, Index + 1, [Char | Acc]);
                true -> % Not a lowercase letter (or not a capital if Acc is empty), so atom name ends here
                    {list_to_binary(lists:reverse(Acc)), Index}
            end
    end.

read_number(Chars, Index) ->
    read_number_acc(Chars, Index, []).

read_number_acc(Chars, Index, Acc) ->
    Len = length(Chars),
    if
        Index > Len -> % Reached end of string
            case Acc of
                [] -> {1, Index}; % No number found, default count is 1
                _ -> {list_to_integer(lists:reverse(Acc)), Index}
            end;
        true ->
            Char = lists:nth(Index, Chars),
            if
                is_digit(Char) ->
                    read_number_acc(Chars, Index + 1, [Char | Acc]);
                true -> % Not a digit, so number ends here
                    case Acc of
                        [] -> {1, Index}; % No number found, default count is 1
                        _ -> {list_to_integer(lists:reverse(Acc)), Index}
                    end
            end
    end.

multiply_counts(CountsMap, Multiplier) ->
    maps:fold(fun(K, V, Acc) -> maps:put(K, V * Multiplier, Acc) end, #{}, CountsMap).

merge_counts(Map1, Map2) ->
    maps:fold(fun(K, V, Acc) -> maps:update_with(K, fun(OldV) -> OldV + V end, V, Acc) end, Map1, Map2).

is_capital(C) -> C >= $A andalso C =< $Z.
is_lowercase(C) -> C >= $a andalso C =< $z.
is_digit(C) -> C >= $0 andalso C =< $9.