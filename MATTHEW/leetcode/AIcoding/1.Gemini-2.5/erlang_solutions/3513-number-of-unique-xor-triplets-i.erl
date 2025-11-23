-module(solution).
-export([xor_triplets/1]).

-include_lib("stdlib/include/array.hrl"). %% Not strictly necessary, but good practice for array module usage
-include_lib("stdlib/include/sets.hrl").   %% Not strictly necessary, but good practice for sets module usage

xor_triplets(Nums) ->
    N = length(Nums),
    case N < 3 of
        true -> 0;
        false ->
            NumsArray = array:from_list(Nums),
            count_triplets_i(NumsArray, N, 0, 0)
    end.

count_triplets_i(NumsArray, N, I, TotalCount) when I < N - 2 ->
    SeenElements = sets:new(),
    NewTotalCount = count_triplets_j(NumsArray, N, I, I + 1, SeenElements, TotalCount),
    count_triplets_i(NumsArray, N, I + 1, NewTotalCount);
count_triplets_i(_NumsArray, _N, _I, TotalCount) ->
    TotalCount.

count_triplets_j(NumsArray, N, I, J, SeenElements, TotalCount) when J < N ->
    ValI = array:get(I, NumsArray),
    ValJ = array:get(J, NumsArray),
    Target = ValI bxor ValJ,

    CurrentTotalCount = if sets:is_element(Target, SeenElements) ->
                            TotalCount + 1;
                        true ->
                            TotalCount
                        end,

    NewSeenElements = sets:add_element(ValJ, SeenElements),
    count_triplets_j(NumsArray, N, I, J + 1, NewSeenElements, CurrentTotalCount);
count_triplets_j(_NumsArray, _N, _I, _J, _SeenElements, TotalCount) ->
    TotalCount.