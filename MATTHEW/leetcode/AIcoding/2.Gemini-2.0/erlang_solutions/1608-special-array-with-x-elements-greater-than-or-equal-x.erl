-module(special_array).
-export([special_array/1]).

special_array(Nums) ->
    special_array_helper(Nums, 0).

special_array_helper(Nums, X) ->
    Count = lists:foldl(fun(Num, Acc) ->
                                  if Num >= X ->
                                      Acc + 1
                                  else
                                      Acc
                                  end
                          end, 0, Nums),
    if Count == X ->
        X
    else
        case X > length(Nums) ->
            -1;
        true ->
            special_array_helper(Nums, X + 1)
        end
    end.