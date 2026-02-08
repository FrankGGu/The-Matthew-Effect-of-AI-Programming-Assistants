-module(solution).
-export([largest_values/1]).

-include_lib("stdlib/include/ms_transform.hrl").

largest_values(Root) ->
    traverse(Root, 0, []).

traverse(null, _, Acc) ->
    lists:reverse(Acc);
traverse({Val, Left, Right}, Level, Acc) ->
    case Acc of
        [] ->
            traverse(Left, Level + 1, [{Level, Val}]);
        [H | T] when H#ms.level == Level ->
            NewAcc = [{Level, max(Val, H#ms.value)} | T],
            traverse(Left, Level + 1, NewAcc);
        [H | T] when H#ms.level < Level ->
            NewAcc = [{Level, Val} | Acc],
            traverse(Left, Level + 1, NewAcc);
        _ ->
            traverse(Left, Level + 1, [{Level, Val} | Acc])
    end,
    traverse(Right, Level + 1, Acc).

-record(ms, {level, value}).