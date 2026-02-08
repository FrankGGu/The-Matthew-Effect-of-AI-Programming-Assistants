-module(count_symmetric_integers).
-export([countSymmetricIntegers/1]).

countSymmetricIntegers(Nums) ->
    lists:foldl(fun(N, Acc) -> 
        case is_symmetric(N) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, Nums).

is_symmetric(N) ->
    Str = integer_to_list(N),
    Len = length(Str),
    if
        Len rem 2 /= 0 -> false;
        true ->
            Mid = Len div 2,
            Left = lists:sublist(Str, Mid),
            Right = lists:sublist(Str, Mid + 1, Len - Mid),
            Left == lists:reverse(Right)
    end.