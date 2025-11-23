-module(solution).
-export([count_palindrome_paths/1]).

count_palindrome_paths(Root) ->
    count_palindrome_paths(Root, 0, #{}).

count_palindrome_paths(nil, _, _) ->
    0;
count_palindrome_paths(#{} = Node, Mask, CountMap) ->
    Key = maps:get(<<"val">>, Node),
    NewMask = Mask bxor (1 bsl (Key - $a)),
    Count = maps:get(NewMask, CountMap, 0),
    Total = Count + count_palindrome_paths(Node#{"left" => nil}, NewMask, CountMap),
    Total + count_palindrome_paths(Node#{"right" => nil}, NewMask, CountMap).

count_palindrome_paths(Node, Mask, CountMap) ->
    Key = maps:get(<<"val">>, Node),
    NewMask = Mask bxor (1 bsl (Key - $a)),
    Count = maps:get(NewMask, CountMap, 0),
    Total = Count,
    Left = count_palindrome_paths(Node#{"left" => nil}, NewMask, maps:put(NewMask, Count + 1, CountMap)),
    Right = count_palindrome_paths(Node#{"right" => nil}, NewMask, maps:put(NewMask, Count + 1, CountMap)),
    Total + Left + Right.