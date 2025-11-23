-module(number_of_atoms).
-export([count_of_atoms/1]).

count_of_atoms(Expr) ->
    {Atoms, _} = parse(Expr, 0, []),
    format(Atoms).

parse([], _, Acc) ->
    {Acc, []};
parse([C | T], I, Acc) when C >= $A andalso C =< $Z ->
    Name = get_name([C | T], []),
    {Num, Rest} = get_num(T, 1),
    parse(Rest, I + 1, [{Name, Num} | Acc]);
parse([C | T], I, Acc) when C >= $a andalso C =< $z ->
    Name = get_name([C | T], [C]),
    {Num, Rest} = get_num(T, 1),
    parse(Rest, I + 1, [{Name, Num} | Acc]);
parse([$(|T], I, Acc) ->
    {SubAtoms, Rest} = parse(T, I + 1, []),
    {Num, Rest2} = get_num(Rest, 1),
    parse(Rest2, I + 1, merge(Acc, SubAtoms, Num));
parse([$)|T], I, Acc) ->
    {Acc, T};
parse([C | T], I, Acc) ->
    parse(T, I + 1, Acc).

get_name([], Acc) ->
    lists:reverse(Acc);
get_name([C | T], Acc) when C >= $a andalso C =< $z ->
    get_name(T, [C | Acc]);
get_name([C | T], Acc) when C >= $A andalso C =< $Z ->
    get_name(T, [C | Acc]);
get_name(_, Acc) ->
    lists:reverse(Acc).

get_num([], Num) ->
    {Num, []};
get_num([C | T], Num) when C >= $0 andalso C =< $9 ->
    get_num(T, Num * 10 + (C - $0));
get_num(_, Num) ->
    {Num, []}.

merge([], _, _) ->
    [];
merge([{Name, Num} | T], SubAtoms, Factor) ->
    {NewNum, NewSub} = merge_sub(SubAtoms, Name, Num * Factor),
    [{Name, NewNum} | merge(T, NewSub, Factor)].

merge_sub([], _, _) ->
    {0, []};
merge_sub([{Name, Num} | T], Target, Factor) ->
    if
        Name == Target ->
            {Num * Factor, T};
        true ->
            {0, [{Name, Num} | T]}
    end.

format(Atoms) ->
    Sorted = lists:sort(fun({A, _}, {B, _}) -> A < B end, Atoms),
    lists:foldl(fun({Name, Num}, Acc) ->
        case Acc of
            [] -> [Name ++ integer_to_list(Num)];
            _ -> [Name ++ integer_to_list(Num) | Acc]
        end
    end, [], Sorted).

count_of_atoms(Expr) ->
    {Atoms, _} = parse(Expr, 0, []),
    format(Atoms).