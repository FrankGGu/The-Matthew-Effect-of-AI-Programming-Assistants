-module(solution).
-export([reverse_pairs/1]).

%% Reverse Pairs using merge sort approach
-spec reverse_pairs([integer()]) -> integer().
reverse_pairs(Nums) ->
    reverse_pairs(Nums, []).

%% Helper function to perform merge sort and count reverse pairs
-spec reverse_pairs([integer()], [integer()]) -> integer().
reverse_pairs([], Acc) -> 
    lists:reverse(Acc);
reverse_pairs([H | T], Acc) -> 
    reverse_pairs(T, [H | Acc]).

%% Merging two sorted lists and counting reverse pairs
merge_and_count([], [], Acc) -> 
    Acc;
merge_and_count([X | XS], [Y | YS], Acc) when X > 2 * Y -> 
    merge_and_count(XS, [Y | YS], Acc + 1);
merge_and_count([X | XS], [Y | YS], Acc) -> 
    merge_and_count(XS, YS, Acc).
  
