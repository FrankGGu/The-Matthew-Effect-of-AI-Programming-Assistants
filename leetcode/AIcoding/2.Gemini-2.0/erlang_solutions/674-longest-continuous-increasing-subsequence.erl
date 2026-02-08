-module(longest_increasing_subsequence).
-export([find_length_of_lcis/1]).

find_length_of_lcis(Nums) ->
    find_length_of_lcis(Nums, 0, 0, 0).

find_length_of_lcis([], _, MaxLen, Len) ->
    max(MaxLen, Len);
find_length_of_lcis([H|T], Prev, MaxLen, Len) ->
    case H > Prev of
        true ->
            find_length_of_lcis(T, H, MaxLen, Len + 1);
        false ->
            find_length_of_lcis(T, H, max(MaxLen, Len), 1)
    end.