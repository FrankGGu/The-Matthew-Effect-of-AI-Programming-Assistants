-module(solution).
-export([find_subsequences/1]).

-spec find_subsequences([integer()]) -> [[integer()]].
find_subsequences(Nums) ->
    find_subsequences(Nums, [], []).

-spec find_subsequences([integer()], [integer()], [[integer()]]) -> [[integer()]].
find_subsequences([], _, Result) -> lists:reverse(Result);
find_subsequences([H | T], Current, Result) when is_list(Current) -> 
    NewResult = case Current of
        [] -> Result;
        [Prev | _] when Prev =< H -> 
            NewSubseq = [H | Current],
            lists:append(Result, [NewSubseq])
    end,
    find_subsequences(T, [H | Current], NewResult);
find_subsequences([H | T], [], Result) ->
    find_subsequences(T, [H], Result).
