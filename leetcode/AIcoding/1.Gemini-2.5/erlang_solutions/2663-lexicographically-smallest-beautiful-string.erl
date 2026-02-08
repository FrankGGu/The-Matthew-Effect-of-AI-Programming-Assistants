-module(solution).
-export([smallestBeautifulString/2]).

smallestBeautifulString(N, K) ->
    MaxChar = $a + K - 1,
    build(0, 0, 0, [], N, MaxChar).

build(Index, PrevChar, PrevPrevChar, AccList, N, MaxChar) ->
    if Index == N ->
        lists:reverse(AccList);
       true ->
        case find_char($a, MaxChar, PrevChar, PrevPrevChar) of
            {ok, C} ->
                build(Index + 1, C, PrevChar, [C | AccList], N, MaxChar);
            none ->
                []
        end
    end.

find_char(CurrentChar, MaxChar, PrevChar, PrevPrevChar) ->
    if CurrentChar > MaxChar ->
        none;
       CurrentChar /= PrevChar andalso CurrentChar /= PrevPrevChar ->
        {ok, CurrentChar};
       true ->
        find_char(CurrentChar + 1, MaxChar, PrevChar, PrevPrevChar)
    end.