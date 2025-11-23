-module(solution).
-export([find_latest_group/2]).

find_latest_group(Arr, M) ->
    N = length(Arr),
    Parent = array:new([{size, N + 2}, {default, -1}]),
    Size = array:new([{size, N + 2}, {default, 0}]),
    Count = array:new([{size, N + 2}, {default, 0}]),
    process(Arr, M, N, Parent, Size, Count, -1).

process([], _M, _N, _Parent, _Size, Count, LastStep) ->
    LastStep;
process([Pos | Rest], M, N, Parent, Size, Count, _LastStep) ->
    {NewParent, NewSize, NewCount} = update(Pos, Parent, Size, Count, M),
    case array:get(M, NewCount) > 0 of
        true -> process(Rest, M, N, NewParent, NewSize, NewCount, length(Rest));
        false -> process(Rest, M, N, NewParent, NewSize, NewCount, -1)
    end.

update(Pos, Parent, Size, Count, M) ->
    Parent1 = array:set(Pos, Pos, Parent),
    Size1 = array:set(Pos, 1, Size),
    Count1 = update_count(1, 1, Count, M),
    Left = Pos - 1,
    Right = Pos + 1,
    {Parent2, Size2, Count2} = union(Pos, Left, Parent1, Size1, Count1, M),
    {Parent3, Size3, Count3} = union(Pos, Right, Parent2, Size2, Count2, M),
    {Parent3, Size3, Count3}.

union(_Pos, Neighbor, Parent, Size, Count, _M) when Neighbor < 1; Neighbor >= array:size(Parent) ->
    {Parent, Size, Count};
union(Pos, Neighbor, Parent, Size, Count, M) ->
    case array:get(Neighbor, Parent) of
        -1 -> {Parent, Size, Count};
        _ ->
            Root1 = find(Pos, Parent),
            Root2 = find(Neighbor, Parent),
            case Root1 =:= Root2 of
                true -> {Parent, Size, Count};
                false ->
                    Size1 = array:get(Root1, Size),
                    Size2 = array:get(Root2, Size),
                    NewCount = update_count(Size1, -1, Count, M),
                    NewCount1 = update_count(Size2, -1, NewCount, M),
                    {Parent1, Size1} = if
                        Size1 >= Size2 ->
                            Parent2 = array:set(Root2, Root1, Parent),
                            Size2 = array:set(Root1, Size1 + Size2, Size),
                            {Parent2, Size2};
                        true ->
                            Parent2 = array:set(Root1, Root2, Parent),
                            Size2 = array:set(Root2, Size1 + Size2, Size),
                            {Parent2, Size2}
                    end,
                    NewCount2 = update_count(Size1 + Size2, 1, NewCount1, M),
                    {Parent1, Size1, NewCount2}
            end
    end.

find(Pos, Parent) ->
    case array:get(Pos, Parent) of
        -1 -> -1;
        Pos -> Pos;
        P ->
            Root = find(P, Parent),
            array:set(Pos, Root, Parent),
            Root
    end.

update_count(Size, Delta, Count, M) ->
    case Size =:= M of
        true -> array:set(M, array:get(M, Count) + Delta, Count);
        false -> Count
    end.