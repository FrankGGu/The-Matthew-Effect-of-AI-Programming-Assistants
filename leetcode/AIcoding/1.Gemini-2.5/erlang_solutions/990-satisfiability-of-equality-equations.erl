-module(satisfiability_of_equality_equations).
-export([equationsSatisfiable/1]).

equationsSatisfiable(Equations) ->
    DSU_AfterEquals = lists:foldl(
        fun(Equation, AccDSU) ->
            [Char1, Op1, Op2, Char2] = Equation,
            if Op1 == $$ andalso Op2 == $$ ->
                union(Char1, Char2, AccDSU);
            true ->
                AccDSU
            end
        end,
        maps:new(),
        Equations
    ),

    lists:all(
        fun(Equation) ->
            [Char1, Op1, Op2, Char2] = Equation,
            if Op1 == $! andalso Op2 == $$ ->
                {_, Root1} = find(Char1, DSU_AfterEquals),
                {_, Root2} = find(Char2, DSU_AfterEquals),
                Root1 /= Root2
            true ->
                true
            end
        end,
        Equations
    ).

find(Char, DSU_Map) ->
    case maps:find(Char, DSU_Map) of
        {ok, Parent} ->
            if Parent == Char -> {DSU_Map, Char};
               true ->
                   {NewDSU_Map, Root} = find(Parent, DSU_Map),
                   {maps:put(Char, Root, NewDSU_Map), Root}
            end;
        error ->
            {maps:put(Char, Char, DSU_Map), Char}
    end.

union(Char1, Char2, DSU_Map) ->
    {DSU_Map1, Root1} = find(Char1, DSU_Map),
    {DSU_Map2, Root2} = find(Char2, DSU_Map1),
    if Root1 == Root2 -> DSU_Map2;
       true -> maps:put(Root2, Root1, DSU_Map2)
    end.