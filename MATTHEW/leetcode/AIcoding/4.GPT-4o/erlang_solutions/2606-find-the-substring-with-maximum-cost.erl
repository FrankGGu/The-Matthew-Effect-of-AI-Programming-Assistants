-module(solution).
-export([maximum_cost_substring/3]).

maximum_cost_substring(Str, chars, values) ->
    MaxCost = lists:max(values),
    {MaxCost, 0} = lists:foldl(fun(Char, {CurMax, CurCost}) ->
        NewCost = if lists:member(Char, chars) -> CurCost + lists:nth(lists:position(Char, chars) + 1, values);
                    true -> CurCost - MaxCost
                end,
        {max(CurMax, NewCost), NewCost}
    end, {0, 0}, Str),
    MaxCost.