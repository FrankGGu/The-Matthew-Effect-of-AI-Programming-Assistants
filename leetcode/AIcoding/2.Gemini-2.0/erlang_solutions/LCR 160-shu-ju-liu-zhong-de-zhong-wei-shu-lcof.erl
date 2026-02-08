-module(median_finder).
-export([new/0, add_num/2, find_median/1]).

new() ->
    {[], []}.

add_num(Num, {Smalls, Larges}) ->
    case Smalls of
        [] ->
            {Smalls, [Num]};
        [Small | _] ->
            if Num > Small then
                {NewSmalls, NewLarges} = insert_large(Num, Larges, Smalls),
                {NewSmalls, NewLarges}
            else
                {NewSmalls, NewLarges} = insert_small(Num, Smalls, Larges),
                {NewSmalls, NewLarges}
            end
    end.

find_median({Smalls, Larges}) ->
    SmallSize = length(Smalls),
    LargeSize = length(Larges),
    if SmallSize == LargeSize then
        (list_to_integer(lists:nth(1, lists:reverse(Smalls))) + list_to_integer(lists:nth(1, Larges))) / 2.0
    else
        case SmallSize > LargeSize of
            true ->
                list_to_integer(lists:nth(1, lists:reverse(Smalls)));
            false ->
                list_to_integer(lists:nth(1, Larges))
        end
    end.

insert_large(Num, Larges, Smalls) ->
    case length(Larges) - length(Smalls) > 0 of
        true ->
            {[lists:nth(1, Larges) | Smalls], lists:delete(lists:nth(1, Larges), Larges)};
        false ->
            {Smalls, insert(Num, Larges)}
    end.

insert_small(Num, Smalls, Larges) ->
    case length(Smalls) - length(Larges) > 0 of
        true ->
            {[lists:nth(1, lists:reverse(Smalls)) | Larges], lists:delete(lists:nth(1, lists:reverse(Smalls)), lists:reverse(Smalls))};
        false ->
            {insert(Num, lists:reverse(Smalls)), Larges}
    end.

insert(Num, List) ->
    insert_helper(Num, List, []).

insert_helper(Num, [], Acc) ->
    lists:reverse([Num | Acc]);
insert_helper(Num, [H | T], Acc) ->
    if Num < H then
        lists:reverse([Num | [H | T] ++ Acc])
    else
        insert_helper(Num, T, [H | Acc])
    end.