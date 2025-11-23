-module(maximum_binary_string_after_change).
-export([maxBinaryAfterChange/1]).

maxBinaryAfterChange(Binary) ->
    maxBinaryAfterChange(Binary, 0, 0).

maxBinaryAfterChange([], _, _) ->
    "";
maxBinaryAfterChange([$0|T], CountZeros, CountOnes) ->
    maxBinaryAfterChange(T, CountZeros + 1, CountOnes);
maxBinaryAfterChange([$1|T], CountZeros, CountOnes) ->
    maxBinaryAfterChange(T, CountZeros, CountOnes + 1);
maxBinaryAfterChange([$?|T], CountZeros, CountOnes) ->
    maxBinaryAfterChange(T, CountZeros, CountOnes + 1).

maxBinaryAfterChange([], CountZeros, CountOnes) ->
    case CountZeros of
        0 -> lists:duplicate(CountOnes, $1);
        _ ->
            if
                CountOnes == 0 ->
                    lists:duplicate(CountZeros, $0);
                true ->
                    lists:flatten([
                        lists:duplicate(CountZeros - 1, $0),
                        "1",
                        lists:duplicate(CountOnes, $1)
                    ])
            end
    end.