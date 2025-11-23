-module(solution).
-export([smallest_trimmed_numbers/3]).

smallest_trimmed_numbers(Nums, Queries) ->
    lists:map(fun({k, trim}) ->
        Trimmed = lists:map(fun(Num) ->
            Len = length(Num),
            Start = max(1, Len - trim + 1),
            string:sub_string(Num, Start, Len)
        end, Nums),
        Indexed = lists:zip(lists:seq(0, length(Trimmed) - 1), Trimmed),
        Sorted = lists:sort(fun({I1, S1}, {I2, S2}) ->
            case S1 == S2 of
                true -> I1 =< I2;
                false -> S1 =< S2
            end
        end, Indexed),
        {KthIndex, _} = lists:nth(k, Sorted),
        KthIndex
    end, Queries).