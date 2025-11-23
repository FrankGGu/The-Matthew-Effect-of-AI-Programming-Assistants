-spec num_similar_groups(Strs :: [unicode:unicode_binary()]) -> integer().
num_similar_groups(Strs) ->
    N = length(Strs),
    Parent = lists:seq(0, N - 1),
    {Parent1, _} = lists:foldl(fun(I, {P, _}) ->
        lists:foldl(fun(J, {PAcc, _}) ->
            case is_similar(lists:nth(I + 1, Strs), lists:nth(J + 1, Strs)) of
                true ->
                    RootI = find(I, PAcc),
                    RootJ = find(J, PAcc),
                    if
                        RootI =/= RootJ ->
                            {setelement(RootJ + 1, PAcc, RootI), ok};
                        true ->
                            {PAcc, ok}
                    end;
                false ->
                    {PAcc, ok}
            end
        end, {P, ok}, lists:seq(I + 1, N - 1))
    end, {Parent, ok}, lists:seq(0, N - 2)),
    sets:size(sets:from_list([find(X, Parent1) || X <- lists:seq(0, N - 1)])).

find(X, Parent) ->
    if
        element(X + 1, Parent) =:= X ->
            X;
        true ->
            find(element(X + 1, Parent), Parent)
    end.

is_similar(A, B) ->
    case {binary_to_list(A), binary_to_list(B)} of
        {Same, Same} -> true;
        {ListA, ListB} ->
            case lists:filter(fun({X, Y}) -> X =/= Y end, lists:zip(ListA, ListB)) of
                [] -> true;
                [{X1, Y1}, {X2, Y2}] -> X1 =:= Y2 andalso X2 =:= Y1;
                _ -> false
            end
    end.