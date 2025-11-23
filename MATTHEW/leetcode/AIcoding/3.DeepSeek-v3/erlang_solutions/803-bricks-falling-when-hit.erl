-module(bricks_falling_when_hit).
-export([hit_bricks/2]).

hit_bricks(Grid, Hits) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],

    % Mark the hits
    HitSet = sets:from_list(Hits),
    Grid1 = lists:map(fun(I) ->
        lists:map(fun(J) ->
            case sets:is_element({I, J}, HitSet) of
                true -> 0;
                false -> lists:nth(J + 1, lists:nth(I + 1, Grid))
            end
        end, lists:seq(0, Cols - 1))
    end, lists:seq(0, Rows - 1)),

    % Union-Find structure
    Parent = maps:new(),
    Size = maps:new(),
    Parent1 = maps:put({-1, -1}, {-1, -1}, Parent),
    Size1 = maps:put({-1, -1}, 1, Size),

    % Initialize Union-Find
    {Parent2, Size2} = lists:foldl(fun(I, {PAcc, SAcc}) ->
        lists:foldl(fun(J, {PAcc1, SAcc1}) ->
            case lists:nth(J + 1, lists:nth(I + 1, Grid1)) of
                1 ->
                    P1 = maps:put({I, J}, {I, J}, PAcc1),
                    S1 = maps:put({I, J}, 1, SAcc1),
                    {P1, S1};
                _ ->
                    {PAcc1, SAcc1}
            end
        end, {PAcc, SAcc}, lists:seq(0, Cols - 1))
    end, {Parent1, Size1}, lists:seq(0, Rows - 1)),

    % Connect bricks
    {Parent3, Size3} = lists:foldl(fun(I, {PAcc, SAcc}) ->
        lists:foldl(fun(J, {PAcc1, SAcc1}) ->
            case lists:nth(J + 1, lists:nth(I + 1, Grid1)) of
                1 ->
                    lists:foldl(fun({Di, Dj}, {PAcc2, SAcc2}) ->
                        Ni = I + Di,
                        Nj = J + Dj,
                        if
                            Ni >= 0, Ni < Rows, Nj >= 0, Nj < Cols ->
                                case lists:nth(Nj + 1, lists:nth(Ni + 1, Grid1)) of
                                    1 ->
                                        union({I, J}, {Ni, Nj}, PAcc2, SAcc2);
                                    _ ->
                                        {PAcc2, SAcc2}
                                end;
                            true ->
                                {PAcc2, SAcc2}
                        end
                    end, {PAcc1, SAcc1}, Directions);
                _ ->
                    {PAcc1, SAcc1}
            end
        end, {PAcc, SAcc}, lists:seq(0, Cols - 1))
    end, {Parent2, Size2}, lists:seq(0, Rows - 1)),

    % Connect top bricks to roof
    {Parent4, Size4} = lists:foldl(fun(J, {PAcc, SAcc}) ->
        case lists:nth(J + 1, hd(Grid1)) of
            1 ->
                union({-1, -1}, {0, J}, PAcc, SAcc);
            _ ->
                {PAcc, SAcc}
        end
    end, {Parent3, Size3}, lists:seq(0, Cols - 1)),

    % Process hits in reverse
    lists:foldr(fun({I, J}, Acc) ->
        case lists:nth(J + 1, lists:nth(I + 1, Grid)) of
            0 ->
                [0 | Acc];
            _ ->
                PrevSize = maps:get(find({-1, -1}, Parent4), Size4, 0),
                Grid2 = set_element(I, set_element(J, 1, lists:nth(I + 1, Grid1)), Grid1),
                Parent5 = maps:put({I, J}, {I, J}, Parent4),
                Size5 = maps:put({I, J}, 1, Size4),
                {Parent6, Size6} = lists:foldl(fun({Di, Dj}, {PAcc, SAcc}) ->
                    Ni = I + Di,
                    Nj = J + Dj,
                    if
                        Ni >= 0, Ni < Rows, Nj >= 0, Nj < Cols ->
                            case lists:nth(Nj + 1, lists:nth(Ni + 1, Grid2)) of
                                1 ->
                                    union({I, J}, {Ni, Nj}, PAcc, SAcc);
                                _ ->
                                    {PAcc, SAcc}
                            end;
                        true ->
                            {PAcc, SAcc}
                    end
                end, {Parent5, Size5}, Directions),
                {Parent7, Size7} = case I =:= 0 of
                    true ->
                        union({-1, -1}, {0, J}, Parent6, Size6);
                    false ->
                        {Parent6, Size6}
                end,
                NewSize = maps:get(find({-1, -1}, Parent7), Size7, 0),
                Delta = max(0, NewSize - PrevSize - 1),
                [Delta | Acc]
        end
    end, [], Hits).

set_element(Index, Value, List) ->
    set_element(Index, Value, List, 0, []).

set_element(Index, Value, [H | T], Current, Acc) ->
    if
        Current =:= Index ->
            lists:reverse(Acc) ++ [Value | T];
        true ->
            set_element(Index, Value, T, Current + 1, [H | Acc])
    end;
set_element(_, _, [], _, Acc) ->
    lists:reverse(Acc).

find(Key, Parent) ->
    case maps:get(Key, Parent, Key) of
        Key -> Key;
        ParentKey ->
            Root = find(ParentKey, Parent),
            Root
    end.

union(A, B, Parent, Size) ->
    RootA = find(A, Parent),
    RootB = find(B, Parent),
    if
        RootA =:= RootB ->
            {Parent, Size};
        true ->
            SizeA = maps:get(RootA, Size, 1),
            SizeB = maps:get(RootB, Size, 1),
            if
                SizeA < SizeB ->
                    Parent1 = maps:put(RootA, RootB, Parent),
                    Size1 = maps:put(RootB, SizeA + SizeB, Size),
                    {Parent1, Size1};
                true ->
                    Parent1 = maps:put(RootB, RootA, Parent),
                    Size1 = maps:put(RootA, SizeA + SizeB, Size),
                    {Parent1, Size1}
            end
    end.