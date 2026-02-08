-module(mini_parser).
-export([parse/1]).

parse(S) ->
    {Result, _} = parse_list(S, 1),
    Result.

parse_list(S, Index) ->
    case S:nth(Index) of
        '[' ->
            {List, NextIndex} = parse_list_helper(S, Index + 1, []),
            {list_to_n_list(List), NextIndex};
        _ ->
            {parse_integer(S, Index)}
    end.

parse_list_helper(S, Index, Acc) ->
    case S:nth(Index) of
        ']' ->
            {lists:reverse(Acc), Index + 1};
        ',' ->
            parse_list_helper(S, Index + 1, Acc);
        '[' ->
            {NestedList, NextIndex} = parse_list(S, Index),
            parse_list_helper(S, NextIndex, [NestedList | Acc]);
        _ when is_digit(S:nth(Index)) or S:nth(Index) == '-' ->
            {Integer, NextIndex} = parse_integer(S, Index),
            parse_list_helper(S, NextIndex, [Integer | Acc]);
        _ ->
            {lists:reverse(Acc), Index + 1}
    end.

parse_integer(S, Index) ->
    {Value, NextIndex} = parse_integer_helper(S, Index, []),
    {list_to_integer(lists:reverse(Value)), NextIndex}.

parse_integer_helper(S, Index, Acc) ->
    case S:nth(Index) of
        Digit when is_digit(Digit) ->
            parse_integer_helper(S, Index + 1, [Digit | Acc]);
        '-' ->
            parse_integer_helper(S, Index + 1, ['-' | Acc]);
        _ ->
            {Acc, Index}
    end.

is_digit(C) ->
    C >= '0' and C =< '9'.

list_to_n_list(L) ->
    lists:map(fun(X) -> create_n_list(X) end, L).

create_n_list(N) when is_integer(N) ->
    NList = n_list:new(),
    n_list:setInteger(NList, N),
    NList;
create_n_list(L) when is_list(L) ->
    NList = n_list:new(),
    n_list:setList(NList, L),
    NList.

-module(n_list).
-export([new/0, setInteger/2, setList/2]).

new() ->
    {integer, 0}.

setInteger({_, _}, Value) when is_integer(Value) ->
    {integer, Value}.

setList({_, _}, Value) when is_list(Value) ->
    {list, Value}.