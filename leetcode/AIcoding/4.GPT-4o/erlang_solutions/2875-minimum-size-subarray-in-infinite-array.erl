-module(solution).
-export([min_size_subarray/2]).

min_size_subarray(Target, Array) ->
    MinLength = length(Array) + 1,
    {MinLength, 0, 0} = lists:foldl(fun(X, {MinLength, Sum, Start}) ->
        Sum1 = Sum + X,
        Start1 = if Sum1 >= Target -> Start; true -> Start + 1 end,
        case Sum1 >= Target of
            true -> 
                NewMinLength = min(MinLength, Start1 - Start + 1),
                {NewMinLength, Sum1 - lists:nth(Start + 1, Array), Start + 1};
            false -> 
                {MinLength, Sum1, Start}
        end
    end, {MinLength, 0, 0}, Array),
    if MinLength == length(Array) + 1 -> 0; true -> MinLength end.