-module(mini_parser).
-export([parse/1]).

parse(S) ->
    parse(S, 0, []).

parse([], _, Acc) ->
    lists:reverse(Acc);
parse([H | T], Pos, Acc) when H == $[ ->
    {List, NewPos} = parse_list(T, 1, []),
    parse(T, NewPos, [List | Acc]);
parse([H | T], Pos, Acc) when H == $] ->
    {lists:reverse(Acc), Pos};
parse([H | T], Pos, Acc) when H == $, ->
    parse(T, Pos + 1, Acc);
parse([H | T], Pos, Acc) when H >= $0, H =< $9 ->
    {Num, NewPos} = parse_number(T, H),
    parse(T, NewPos, [list_to_integer([H | Num]) | Acc]);
parse([H | T], Pos, Acc) when H == $- ->
    {Num, NewPos} = parse_number(T, H),
    parse(T, NewPos, [list_to_integer([H | Num]) | Acc]).

parse_list([], _, Acc) ->
    {lists:reverse(Acc), 0};
parse_list([H | T], Depth, Acc) when H == $[ ->
    {List, NewPos} = parse_list(T, Depth + 1, []),
    parse_list(T, NewPos, [List | Acc]);
parse_list([H | T], Depth, Acc) when H == $] ->
    {lists:reverse(Acc), Depth + 1};
parse_list([H | T], Depth, Acc) when H == $, ->
    parse_list(T, Depth, Acc);
parse_list([H | T], Depth, Acc) when H >= $0, H =< $9 ->
    {Num, NewPos} = parse_number(T, H),
    parse_list(T, NewPos, [list_to_integer([H | Num]) | Acc]);
parse_list([H | T], Depth, Acc) when H == $- ->
    {Num, NewPos} = parse_number(T, H),
    parse_list(T, NewPos, [list_to_integer([H | Num]) | Acc]).

parse_number([], C) ->
    {[C], 0};
parse_number([H | T], C) when H >= $0, H =< $9 ->
    parse_number(T, [C | H]);
parse_number([H | T], C) ->
    {[C], 0}.