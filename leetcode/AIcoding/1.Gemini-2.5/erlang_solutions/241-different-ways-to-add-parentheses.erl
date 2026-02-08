-module(solution).
-export([diff_ways_to_add_parentheses/1]).

diff_ways_to_add_parentheses(Expression) ->
    {Results, _Memo} = solve(Expression, #{}),
    Results.

solve(Expression, Memo) ->
    case maps:find(Expression, Memo) of
        {ok, Results} ->
            {Results, Memo};
        _ ->
            Len = length(Expression),

            {FinalResults, FinalMemo} = lists:foldl(
                fun(Index, {AccResults, AccMemo}) ->
                    Char = lists:nth(Index, Expression),
                    case is_operator(Char) of
                        true ->
                            LeftPart = lists:sublist(Expression, 1, Index - 1),
                            RightPart = lists:sublist(Expression, Index + 1, Len - Index),

                            {LeftRes, Memo1} = solve(LeftPart, AccMemo),
                            {RightRes, Memo2} = solve(RightPart, Memo1),

                            Combined = combine_results(LeftRes, RightRes, Char),
                            {AccResults ++ Combined, Memo2};
                        false ->
                            {AccResults, AccMemo}
                    end
                end,
                {[], Memo},
                lists:seq(1, Len)
            ),

            ActualResults = case FinalResults of
                [] ->
                    [list_to_integer(Expression)];
                _ ->
                    FinalResults
            end,

            {ActualResults, maps:put(Expression, ActualResults, FinalMemo)}
    end.

is_operator(C) ->
    C == $++ orelse C == $- orelse C == $*.

combine_results(LeftResults, RightResults, Operator) ->
    [ calculate(L, R, Operator) || L <- LeftResults, R <- RightResults ].

calculate(A, B, Operator) ->
    case Operator of
        $+ -> A + B;
        $- -> A - B;
        $* -> A * B
    end.