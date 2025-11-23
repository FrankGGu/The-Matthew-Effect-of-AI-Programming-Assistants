-module(solution).
-export([mergeTwoLists/2]).

mergeTwoLists(nil, List2) ->
    List2;
mergeTwoLists(List1, nil) ->
    List1;
mergeTwoLists({Val1, Next1}, {Val2, Next2}) when Val1 =< Val2 ->
    {Val1, mergeTwoLists(Next1, {Val2, Next2})};
mergeTwoLists({Val1, Next1}, {Val2, Next2}) -> % Val2 < Val1
    {Val2, mergeTwoLists({Val1, Next1}, Next2)}.