-spec count_submatrices(Matrix :: [[integer()]], K :: integer()) -> integer().
count_submatrices(Matrix, K) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Prefix = lists:duplicate(Rows + 1, lists:duplicate(Cols + 1, 0)),
    {_, NewPrefix} = lists:foldl(fun(I, {AccI, PrefixAcc}) ->
        lists:foldl(fun(J, {AccJ, PrefixJ}) ->
            Sum = lists:nth(I, lists:nth(J, Matrix)) + 
                  lists:nth(I, lists:nth(J + 1, PrefixJ)) + 
                  lists:nth(I + 1, lists:nth(J, PrefixJ)) - 
                  lists:nth(I, lists:nth(J, PrefixJ)),
            NewRow = set_nth(I + 1, set_nth(J + 1, Sum, lists:nth(I + 1, PrefixJ)), PrefixJ),
            {AccJ + 1, NewRow}
        end, {1, PrefixAcc}, lists:seq(1, Cols))
    end, {1, Prefix}, lists:seq(1, Rows)),
    count(NewPrefix, K, Rows, Cols).

set_nth(1, Val, [H|T]) -> [Val|T];
set_nth(N, Val, [H|T]) -> [H|set_nth(N - 1, Val, T)].

count(Prefix, K, Rows, Cols) ->
    Res = lists:foldl(fun(I, AccI) ->
        lists:foldl(fun(J, AccJ) ->
            SubCount = lists:foldl(fun(X, AccX) ->
                lists:foldl(fun(Y, AccY) ->
                    Sum = lists:nth(X + 1, lists:nth(Y + 1, Prefix)) - 
                          lists:nth(I, lists:nth(Y + 1, Prefix)) - 
                          lists:nth(X + 1, lists:nth(J, Prefix)) + 
                          lists:nth(I, lists:nth(J, Prefix)),
                    if Sum < K -> AccY + 1; true -> AccY end
                end, 0, lists:seq(J, Cols))
            end, 0, lists:seq(I, Rows)),
            AccJ + SubCount
        end, 0, lists:seq(1, Cols))
    end, 0, lists:seq(1, Rows)),
    Res.