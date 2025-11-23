-module(minimize_result_by_adding_parentheses_to_expression).
-export([minimizeResult/1]).

minimizeResult(Expression) ->
    Numbers = parse_expression(Expression),
    Length = length(Numbers),
    {MinValue, _} = lists:foldl(fun(I, {MinVal, MinIndex}) ->
        {Left, Right} = split_at(I, Numbers),
        Result = calculate_result(Left, Right),
        if
            Result < MinVal -> {Result, I};
            true -> {MinVal, MinIndex}
        end
    end, {infinity, 0}, lists:seq(1, Length - 1)),
    insert_parentheses(Expression, MinIndex).

parse_expression(Str) ->
    parse_expression(Str, [], []).

parse_expression([], AccNum, AccOp) ->
    [list_to_integer(lists:reverse(AccNum))];
parse_expression([$+|T], AccNum, AccOp) ->
    parse_expression(T, [], [$+ | AccOp]);
parse_expression([$*|T], AccNum, AccOp) ->
    parse_expression(T, [], [$* | AccOp]);
parse_expression([C|T], AccNum, AccOp) when C >= $0, C =< $9 ->
    parse_expression(T, [C | AccNum], AccOp);
parse_expression([C|T], AccNum, AccOp) ->
    parse_expression(T, [C | AccNum], AccOp).

split_at(N, List) ->
    split_at(N, List, [], []).

split_at(0, List, Left, Right) ->
    {lists:reverse(Left), lists:reverse(Right)};
split_at(_, [], Left, Right) ->
    {lists:reverse(Left), lists:reverse(Right)};
split_at(N, [H|T], Left, Right) ->
    split_at(N - 1, T, [H | Left], Right).

calculate_result(Left, Right) ->
    calculate_result(Left, Right, 0).

calculate_result([], [], Val) ->
    Val;
calculate_result([H|T], Right, Val) ->
    calculate_result(T, Right, Val + H);
calculate_result([], [H|T], Val) ->
    calculate_result([], T, Val * H).

insert_parentheses(Str, Index) ->
    StrList = string:to_list(Str),
    {LeftPart, RightPart} = split_at(Index, StrList),
    LeftStr = lists:sublist(StrList, Index),
    RightStr = lists:sublist(StrList, Index + 1, length(StrList) - Index),
    [$( | LeftStr] ++ LeftStr ++ [$( | RightStr] ++ [")" | RightStr].

split_at(N, List, Left, Right) ->
    split_at(N, List, Left, Right, 0).

split_at(N, List, Left, Right, Count) when Count < N ->
    split_at(N, tl(List), [hd(List) | Left], Right, Count + 1);
split_at(_, List, Left, Right, _) ->
    {Left, List ++ Right}.