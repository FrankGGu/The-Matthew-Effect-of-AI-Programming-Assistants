-module(solution).
-export([checkOnesSegment/1]).

checkOnesSegment(BinaryString) ->
    case string:tokens(BinaryString, "0") of
        Segments when length(Segments) =< 2 -> true;
        _ -> false
    end.