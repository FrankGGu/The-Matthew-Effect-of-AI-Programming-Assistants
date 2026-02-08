-module(solution).
-export([lis/1]).

lis(Nums) ->
    % The 'tails' list (conceptually) will be represented by a gb_trees.
    % The gb_trees stores the smallest ending element of all increasing subsequences of a certain length.
    % Keys in the gb_trees are the actual numbers from Nums. The values can be anything (e.g., 'true').
    % The size of the gb_trees at the end will be the length of the LIS.
    InitialTails = gb_trees:empty(),

    FinalTails = lists:foldl(fun(Num, Tails) ->
                                 % Find the smallest element in Tails that is >= Num.
                                 % gb_trees:iterator(Tails, Num) returns an iterator positioned at the first element
                                 % whose key is greater than or equal to Num.
                                 Iterator = gb_trees:iterator(Tails, Num),
                                 case gb_trees:next(Iterator) of
                                     none ->
                                         % Num is greater than all elements currently in Tails.
                                         % This means we can extend the longest increasing subsequence found so far.
                                         % Add Num to Tails.
                                         gb_trees:insert(Num, true, Tails);
                                     {Key, _Value, _NewIterator} ->
                                         % Found an element 'Key' in Tails such that Key >= Num.
                                         % This means we can form an increasing subsequence of the same length
                                         % but ending with a smaller value (Num).
                                         % Replace 'Key' with 'Num' in Tails.
                                         gb_trees:insert(Num, true, gb_trees:delete(Key, Tails))
                                 end
                             end, InitialTails, Nums),

    % The size of the gb_trees is the length of the Longest Increasing Subsequence.
    gb_trees:size(FinalTails).