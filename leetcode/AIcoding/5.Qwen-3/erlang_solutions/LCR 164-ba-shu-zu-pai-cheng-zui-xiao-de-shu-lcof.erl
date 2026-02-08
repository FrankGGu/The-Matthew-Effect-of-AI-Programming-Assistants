-module(solution).
-export([find_password/1]).

find_password(Cipher) ->
    find_password(Cipher, 0, []).

find_password([], _, Acc) ->
    lists:reverse(Acc);
find_password([H|T], Index, Acc) ->
    case H of
        0 -> find_password(T, Index + 1, [Index | Acc]);
        _ -> find_password(T, Index + 1, Acc)
    end.