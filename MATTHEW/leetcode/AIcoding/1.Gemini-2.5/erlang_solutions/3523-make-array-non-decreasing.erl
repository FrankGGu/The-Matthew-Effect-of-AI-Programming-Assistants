-module(solution).
-export([make_array_non_decreasing/1]).

-spec make_array_non_decreasing(Nums :: [integer()]) -> integer().
make_array_non_decreasing(Nums) ->
    N = length(Nums),
    LNDS_Length = lnds_length(Nums),
    N - LNDS_Length.

lnds_length(Nums) ->
    Tree = lists:foldl(fun(Num, AccTree) ->
        case gb_trees:lookup_gt(Num, AccTree) of
            {ok, {KeyToReplace, _}} ->
                % If an element strictly greater than Num is found,
                % replace it with Num to potentially form a shorter or
                % smaller-ending non-decreasing subsequence of the same length.
                gb_trees:insert(Num, true, gb_trees:delete(KeyToReplace, AccTree));
            error ->
                % If no element strictly greater than Num is found,
                % Num extends the longest non-decreasing subsequence.
                gb_trees:insert(Num, true, AccTree)
        end
    end, gb_trees:empty(), Nums),
    gb_trees:size(Tree).