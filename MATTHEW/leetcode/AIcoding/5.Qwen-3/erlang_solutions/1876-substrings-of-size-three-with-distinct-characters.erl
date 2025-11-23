-module(substrings_of_size_three_with_distinct_characters).
-export([countGoodSubstrings/1]).

countGoodSubstrings(S) ->
    countGoodSubstrings(S, 0, 0).

countGoodSubstrings([], _, Count) ->
    Count;
countGoodSubstrings([_], _, Count) ->
    Count;
countGoodSubstrings([A,B,C|T], Index, Count) ->
    if
        A /= B andalso B /= C andalso A /= C ->
            countGoodSubstrings([B,C|T], Index + 1, Count + 1);
        true ->
            countGoodSubstrings([B,C|T], Index + 1, Count)
    end.