-module(solution).
-export([kth_largest_xor/2]).

kth_largest_xor(Matrix, K) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    MaxHeap = lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            Val = get_xor(Matrix, I, J),
            erlang:put({i, J}, Val),
            heap:add(Acc2, Val)
        end, Acc, lists:seq(0, Cols-1))
    end, [], lists:seq(0, Rows-1)),
    lists:nth(K, lists:reverse(lists:usort(heap:to_list(MaxHeap)))).

get_xor(Matrix, I, J) ->
    case I of
        0 when J == 0 -> hd(hd(Matrix));
        0 -> get_xor(Matrix, I, J-1) bxor hd(lists:nth(J+1, hd(Matrix)));
        _ when J == 0 -> get_xor(Matrix, I-1, J) bxor hd(lists:nth(I+1, Matrix));
        _ -> get_xor(Matrix, I-1, J) bxor get_xor(Matrix, I, J-1) bxor get_xor(Matrix, I-1, J-1) bxor hd(lists:nth(I+1, Matrix)) 
    end.

heap:add([], Val) -> [Val];
heap:add([H|T], Val) when Val >= H -> [Val | [H | T]];
heap:add([H|T], Val) -> [H | heap:add(T, Val)].

heap:to_list([]) -> [];
heap:to_list([H|T]) -> [H | heap:to_list(T)].