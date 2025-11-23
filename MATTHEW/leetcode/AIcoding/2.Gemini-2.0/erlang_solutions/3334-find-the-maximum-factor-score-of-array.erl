-module(max_factor_score).
-export([maximum_factor_score/1]).

maximum_factor_score(Nums) ->
    lists:foldl(
        fun(Num, {MaxScore, Sum}) ->
            FactorScore = factor_score(Num),
            case FactorScore > MaxScore of
                true -> {FactorScore, Sum + FactorScore};
                false -> {MaxScore, Sum + FactorScore}
            end
        end,
        {0, 0},
        Nums
    ).

factor_score(1) -> 1;
factor_score(N) ->
    factor_score_helper(N, 2, 0).

factor_score_helper(N, Factor, Count) when N =< 1 ->
    Count;
factor_score_helper(N, Factor, Count) when Factor * Factor > N ->
    if N > 1 then
        Count + 1
    else
        Count
    end;
factor_score_helper(N, Factor, Count) when N rem Factor == 0 ->
    factor_score_helper(N div Factor, Factor, Count + 1);
factor_score_helper(N, Factor, Count) ->
    factor_score_helper(N, Factor + 1, Count).

maximum_factor_score(Nums) ->
    {_, Sum} = lists:foldl(
        fun(Num, {MaxScore, Sum}) ->
            Score = factor_score(Num),
            NewMaxScore = max(MaxScore, Score),
            {NewMaxScore, Sum + Score}
        end,
        {0, 0},
        Nums
    ),
    Sum.