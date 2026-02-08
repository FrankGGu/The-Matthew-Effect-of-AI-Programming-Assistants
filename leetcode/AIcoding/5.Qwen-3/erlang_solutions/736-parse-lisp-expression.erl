-module(parse_lisp_expression).
-export([parse/1]).

parse(S) ->
    {Result, _} = parse_expr(S, 0, [], []),
    Result.

parse_expr([], _, _, _) -> {[], 0};
parse_expr([$\s|T], Pos, Stack, Acc) -> parse_expr(T, Pos + 1, Stack, Acc);
parse_expr([$\(|T], Pos, Stack, Acc) ->
    NewStack = [Acc | Stack],
    parse_expr(T, Pos + 1, NewStack, []);
parse_expr([$\)|T], Pos, [Prev|Rest], Acc) ->
    NewAcc = lists:reverse(Acc),
    case Rest of
        [] -> {lists:reverse([NewAcc | Prev]), Pos + 1};
        _ -> parse_expr(T, Pos + 1, Rest, [NewAcc | Prev])
    end;
parse_expr([C|T], Pos, Stack, Acc) when C >= $0, C =< $9 ->
    {Num, NewPos} = read_number(T, Pos + 1, [C]),
    parse_expr(T, NewPos, Stack, [Num | Acc]);
parse_expr([C|T], Pos, Stack, Acc) when C == $- ->
    {Num, NewPos} = read_number(T, Pos + 1, [C]),
    parse_expr(T, NewPos, Stack, [Num | Acc]);
parse_expr([C|T], Pos, Stack, Acc) ->
    {Symbol, NewPos} = read_symbol(T, Pos + 1, [C]),
    parse_expr(T, NewPos, Stack, [Symbol | Acc]).

read_number([], Pos, Acc) -> {list_to_integer(lists:reverse(Acc)), Pos};
read_number([C|T], Pos, Acc) when C >= $0, C =< $9 ->
    read_number(T, Pos + 1, [C | Acc]);
read_number(_, Pos, Acc) -> {list_to_integer(lists:reverse(Acc)), Pos}.

read_symbol([], Pos, Acc) -> {lists:reverse(Acc), Pos};
read_symbol([C|T], Pos, Acc) when C == $\s; C == $\); C == $\( ->
    {lists:reverse(Acc), Pos};
read_symbol([C|T], Pos, Acc) ->
    read_symbol(T, Pos + 1, [C | Acc]).