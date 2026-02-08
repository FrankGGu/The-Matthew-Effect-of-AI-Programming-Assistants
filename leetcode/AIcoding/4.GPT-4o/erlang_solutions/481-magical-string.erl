-module(solution).
-export([magical_string/1]).

%% Return the number of '1's in the first n numbers of the magical string.
-spec magical_string(integer()) -> integer().
magical_string(N) ->
    magical_string(N, "1221121221221121122", 0, 0).

%% Helper function to generate the magical string and count the '1's.
-spec magical_string(integer(), string(), integer(), integer()) -> integer().
magical_string(0, _, Count, _) -> Count;
magical_string(N, String, Count, Index) when N > 0 ->
    NewString = case lists:nth(Index + 1, String) of
                    $1 -> String ++ "1";
                    $2 -> String ++ "2"
                end,
    magical_string(N - 1, NewString, Count + if lists:nth(Index, NewString) == $1 -> 1; true -> 0 end, Index + 1).
