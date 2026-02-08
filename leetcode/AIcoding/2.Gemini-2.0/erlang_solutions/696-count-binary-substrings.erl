-module(count_binary_substrings).
-export([countBinarySubstrings/1]).

countBinarySubstrings(S) ->
    countBinarySubstrings_helper(S, [], 0).

countBinarySubstrings_helper([], Acc, Count) ->
    Count;
countBinarySubstrings_helper(S, [], Count) ->
    {Group, Rest} = group_consecutive(S, hd(S)),
    countBinarySubstrings_helper(Rest, [length(Group)], Count);
countBinarySubstrings_helper(S, [Prev | _], Count) ->
    {Group, Rest} = group_consecutive(S, hd(S)),
    Curr = length(Group),
    NewCount = Count + min(Prev, Curr),
    countBinarySubstrings_helper(Rest, [Curr, Prev], NewCount).

group_consecutive([], _) ->
    {[], []};
group_consecutive([H | T], Char) when H == Char ->
    {Group, Rest} = group_consecutive(T, Char),
    {[H | Group], Rest};
group_consecutive(List, _) ->
    {[], List}.