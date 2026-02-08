-module(split_the_array).
-export([splitArray/1]).

splitArray(Numbers) ->
    splitArray(Numbers, 0, 0, 0).

splitArray([], _, _, _) ->
    false;

splitArray([N | Rest], LeftSum, RightSum, Index) ->
    case Index of
        0 ->
            splitArray(Rest, N, RightSum, Index + 1);
        _ ->
            case LeftSum of
                Sum when Sum >= RightSum ->
                    splitArray(Rest, LeftSum + N, RightSum, Index + 1);
                _ ->
                    splitArray(Rest, LeftSum, RightSum + N, Index + 1)
            end
    end.

splitArray(_, LeftSum, RightSum, _) ->
    LeftSum >= RightSum.