-module(solution).
-export([can_be_increasing/1]).

-spec can_be_increasing(Nums :: [integer()]) -> boolean().
can_be_increasing(Nums) ->
    Len = length(Nums),
    is_strictly_increasing(Nums) orelse
    check_removals(Nums, 0, Len).

check_removals(OriginalNums, CurrentIndex, Len) when CurrentIndex < Len ->
    NewList = remove_at_index(OriginalNums, CurrentIndex, [], 0),
    is_strictly_increasing(NewList) orelse check_removals(OriginalNums, CurrentIndex + 1, Len);
check_removals(_OriginalNums, _CurrentIndex, _Len) ->
    false.

remove_at_index(Original, SkipIndex, Acc, CurrentIndex) ->
    case Original of
        [] -> lists:reverse(Acc);
        [H | T] ->
            if CurrentIndex == SkipIndex ->
                remove_at_index(T, SkipIndex, Acc, CurrentIndex + 1);
            else
                remove_at_index(T, SkipIndex, [H | Acc], CurrentIndex + 1)
            end
    end.

is_strictly_increasing([]) -> true;
is_strictly_increasing([_]) -> true;
is_strictly_increasing([H1, H2 | T]) ->
    H1 < H2 andalso is_strictly_increasing([H2 | T]).