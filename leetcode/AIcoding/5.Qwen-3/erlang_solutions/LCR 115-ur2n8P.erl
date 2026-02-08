-module(reconstruct_queue).
-export([reconstruct/1]).

reconstruct(Queue) ->
    Sorted = lists:sort(fun(A, B) ->
        if
            hd(A) > hd(B) -> true;
            hd(A) == hd(B) -> hd(tl(A)) < hd(tl(B));
            true -> false
        end
    end, Queue),
    reconstruct_helper(Sorted, []).

reconstruct_helper([], Result) ->
    Result;
reconstruct_helper([H | T], Result) ->
    [Height, Count] = H,
    Inserted = insert_at(Count + 1, H, Result),
    reconstruct_helper(T, Inserted).

insert_at(N, X, List) ->
    insert_at(N, X, List, []).

insert_at(1, X, List, Acc) ->
    lists:reverse([X | Acc]) ++ List;
insert_at(N, X, [H | T], Acc) ->
    insert_at(N - 1, X, T, [H | Acc]).