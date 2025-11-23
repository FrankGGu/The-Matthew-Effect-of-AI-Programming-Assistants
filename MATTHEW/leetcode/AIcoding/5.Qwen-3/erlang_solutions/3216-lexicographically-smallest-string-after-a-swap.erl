-module(lexicographically_smallest_string_after_a_swap).
-export([lexicographical_smallest_string/1]).

lexicographical_smallest_string(S) ->
    List = string:to_list(S),
    len(List, 0, length(List), List).

len(_, _, N, List) when N == 0 ->
    string:from_list(List);
len(I, J, N, List) when J < N ->
    case lists:nth(J + 1, List) < lists:nth(I + 1, List) of
        true ->
            Temp = lists:nth(J + 1, List),
            lists:replace(J + 1, Temp, lists:replace(I + 1, lists:nth(I + 1, List), List));
        false ->
            len(I, J + 1, N, List)
    end;
len(I, J, N, List) ->
    len(I + 1, 0, N, List).