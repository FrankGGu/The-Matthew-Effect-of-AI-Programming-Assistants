-module(solution).
-export([findMaximumXOR/1]).

-define(MAX_BIT, 30).

findMaximumXOR([H|T]) ->
    %% Initialize the Trie with the first number.
    InitialTrie = trie_insert(#{}, H, ?MAX_BIT),
    %% Initial maximum XOR is 0 (e.g., H XOR H).
    InitialMaxXOR = 0,

    %% Fold over the rest of the numbers in the list.
    %% The state for the fold is {CurrentTrie, CurrentMaxXOR}.
    {_FinalTrie, OverallMaxXOR} = lists:foldl(
        fun(Num, {CurrentTrie, CurrentMaxXOR}) ->
            %% For each number, find the maximum XOR it can form with any number
            %% already present in the CurrentTrie.
            CandidateXOR = trie_find_max_xor(CurrentTrie, Num, ?MAX_BIT, 0),

            %% Insert the current number into the Trie for future comparisons.
            NewTrie = trie_insert(CurrentTrie, Num, ?MAX_BIT),

            %% Update the overall maximum XOR found so far.
            {NewTrie, max(CurrentMaxXOR, CandidateXOR)}
        end,
        {InitialTrie, InitialMaxXOR},
        T %% Process the tail of the list
    ),
    OverallMaxXOR.

trie_insert(Trie, _Num, -1) ->
    Trie; %% Base case: all bits processed
trie_insert(Trie, Num, BitIdx) ->
    Bit = (Num bsr BitIdx) band 1, %% Get the current bit of Num
    Child = maps:get(Bit, Trie, #{}), %% Get the existing child node or an empty map if it doesn't exist
    NewChild = trie_insert(Child, Num, BitIdx - 1), %% Recursively insert into the child
    maps:put(Bit, NewChild, Trie). %% Update the current Trie node with the new child

trie_find_max_xor(Trie, _Num, -1, CurrentXOR) ->
    CurrentXOR; %% Base case: all bits processed, return accumulated XOR
trie_find_max_xor(Trie, Num, BitIdx, CurrentXOR) ->
    NumBit = (Num bsr BitIdx) band 1, %% Get the current bit of Num
    DesiredBit = 1 - NumBit, %% The bit we want to find in the Trie to maximize XOR

    %% Try to find the 'DesiredBit' path first.
    case maps:is_key(DesiredBit, Trie) of
        true ->
            %% If the desired path exists, take it. This bit contributes 1 to the XOR sum.
            Child = maps:get(DesiredBit, Trie),
            trie_find_max_xor(Child, Num, BitIdx - 1, CurrentXOR bor (1 bsl BitIdx));
        false ->
            %% If the desired path does not exist, we must take the path matching 'NumBit'.
            %% This means the current bit contributes 0 to the XOR sum.
            %% This path must exist if the Trie is not empty at this level, as numbers
            %% in the Trie must have either a 0 or a 1 at this bit position.
            Child = maps:get(NumBit, Trie),
            trie_find_max_xor(Child, Num, BitIdx - 1, CurrentXOR)
    end.