-module(different_ways_to_add_parentheses).
-export([diff_ways_to_compute/1]).

diff_ways_to_compute(Expr) ->
    parse(Expr).

parse([]) ->
    [];
parse([C | Rest]) when C >= $0, C =< $9 ->
    {Num, NewRest} = read_number([C | Rest]),
    [Num | parse(NewRest)];
parse([Op | Rest]) ->
    [Op | parse(Rest)].

read_number([C | Rest]) when C >= $0, C =< $9 ->
    read_number(Rest, [C]).

read_number([], Acc) ->
    {list_to_integer(lists:reverse(Acc)), []};
read_number([C | Rest], Acc) when C >= $0, C =< $9 ->
    read_number(Rest, [C | Acc]);
read_number([_ | Rest], Acc) ->
    {list_to_integer(lists:reverse(Acc)), Rest}.

diff_ways_to_compute(ExprList) ->
    compute(ExprList).

compute([]) ->
    [];
compute([X]) ->
    [X];
compute(ExprList) ->
    Results = [],
    lists:foldl(fun({Op, Pos}, Acc) ->
        LeftResults = compute(lists:sublist(ExprList, 1, Pos - 1)),
        RightResults = compute(lists:sublist(ExprList, Pos + 1, length(ExprList) - Pos)),
        lists:foldl(fun(L, Acc2) ->
            lists:foldl(fun(R, Acc3) ->
                case Op of
                    $+ -> [L + R | Acc3];
                    $- -> [L - R | Acc3];
                    $* -> [L * R | Acc3]
                end
            end, Acc2, RightResults)
        end, Acc, LeftResults)
    end, Results, find_ops(ExprList)).

find_ops(ExprList) ->
    find_ops(ExprList, 1, []).

find_ops([], _, Acc) ->
    Acc;
find_ops([Op | Rest], Pos, Acc) when Op == $+; Op == $-; Op == $* ->
    find_ops(Rest, Pos + 1, [{Op, Pos} | Acc]);
find_ops([_ | Rest], Pos, Acc) ->
    find_ops(Rest, Pos + 1, Acc).