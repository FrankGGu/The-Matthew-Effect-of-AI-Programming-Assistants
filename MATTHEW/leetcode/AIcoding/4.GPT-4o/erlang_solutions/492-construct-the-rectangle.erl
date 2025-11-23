-module(solution).
-export([find_subsequences/1]).

%% Helper function to generate all non-decreasing subsequences
-spec find_subsequences([integer()]) -> [[integer()]].
find_subsequences(Nums) ->
    find_subsequences(Nums, [], []).

%% Main recursive function to generate subsequences
-spec find_subsequences([integer()], [integer()], [[integer()]]) -> [[integer()]].
find_subsequences([], _, Result) -> lists:reverse(Result);
find_subsequences([H | T], [], Result) ->
    find_subsequences(T, [H], Result);
find_subsequences([H | T], Acc, Result) when H >= hd(Acc) ->
    find_subsequences(T, [H | Acc], Result);
find_subsequences([_ | T], Acc, Result) ->
    find_subsequences(T, Acc, Result).

%% Call find_subsequences with the given nums list
