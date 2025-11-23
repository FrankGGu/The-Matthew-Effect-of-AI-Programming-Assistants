-module(solution).
-export([longest_uploaded_prefix/1]).

longest_uploaded_prefix(Str) ->
    longest_uploaded_prefix(Str, 0, 0).

longest_uploaded_prefix([], Max, _) -> Max;
longest_uploaded_prefix([H | T], Max, Count) when H =:= $a -> 
    longest_uploaded_prefix(T, max(Max, Count + 1), Count + 1);
longest_uploaded_prefix([H | T], Max, Count) when H =:= $b -> 
    longest_uploaded_prefix(T, Max, 0);
longest_uploaded_prefix([_ | T], Max, Count) -> 
    longest_uploaded_prefix(T, Max, Count).