-module(solution).
-export([convert/1]).

convert(List) ->
    {Ok, Result} = convert_helper(List, [], 0),
    lists:reverse(Result).

convert_helper([], Acc, _) ->
    {ok, Acc};
convert_helper([H | T], Acc, Count) when Count < H ->
    convert_helper(T, [[H | lists:duplicate(H, 1)] | Acc], Count + 1);
convert_helper([H | T], [[H1 | Rest] | Acc], Count) when Count >= H ->
    convert_helper(T, [[H | Rest] | Acc], 1).