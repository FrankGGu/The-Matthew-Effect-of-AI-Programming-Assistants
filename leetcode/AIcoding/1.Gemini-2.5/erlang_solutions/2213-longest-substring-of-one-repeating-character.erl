-module(solution).
-export([longest_substring_of_one_repeating_character/3]).

-record(node_val, {
    len,             % Length of the segment
    char,            % Character if the entire segment is homogeneous, else nil
    prefix_len,      % Length of the longest prefix of repeating characters
    prefix_char,     % Character of the longest prefix
    suffix_len,      % Length of the longest suffix of repeating characters
    suffix_char,     % Character of the longest suffix
    max_len          % Length of the longest repeating character substring within this segment
}).

-record(tree_node, {
    val :: #node_val{},       % The computed value for this segment
    left :: #tree_node{} | nil, % Left child subtree
    right :: #tree_node{} | nil % Right child subtree
}).

longest_substring_of_one_repeating_character(S, S_changes, Index_changes) ->
    N = length(S),
    S_array = array:from_list(S), % Convert list to array for O(1) character access
    InitialTree = build(S_array, 0, N - 1),
    process_queries(S_changes, Index_changes, InitialTree, N, []).

process_queries([], [], _Tree, _N, Acc) ->
    lists:reverse(Acc);
process_queries([NewChar | RestSChanges], [Index | RestIndexChanges], CurrentTree, N, Acc) ->
    NewTree = update(CurrentTree, 0, N - 1, Index, NewChar),
    Result = NewTree#tree_node.val#node_val.max_len,
    process_queries(RestSChanges, RestIndexChanges, NewTree, N, [Result | Acc]).

build(S_array, Start, End) when Start == End ->
    Char = array:get(Start, S_array), % O(1) access to character
    Val = #node_val{len = 1, char = Char,
                     prefix_len = 1, prefix_char = Char,
                     suffix_len = 1, suffix_char = Char,
                     max_len = 1},
    #tree_node{val = Val, left = nil, right = nil};
build(S_array, Start, End) ->
    Mid = (Start + End) div 2,
    LeftTree = build(S_array, Start, Mid),
    RightTree = build(S_array, Mid + 1, End),
    NodeVal = merge(LeftTree#tree_node.val, RightTree#tree_node.val),
    #tree_node{val = NodeVal, left = LeftTree, right = RightTree}.

update(Tree, CurrentStart, CurrentEnd, TargetIndex, NewChar) when CurrentStart == CurrentEnd ->
    % This is a leaf node, create a new one with the updated character
    Val = #node_val{len = 1, char = NewChar,
                     prefix_len = 1, prefix_char = NewChar,
                     suffix_len = 1, suffix_char = NewChar,
                     max_len = 1},
    #tree_node{val = Val, left = nil, right = nil};
update(Tree, CurrentStart, CurrentEnd, TargetIndex, NewChar) ->
    Mid = (CurrentStart + CurrentEnd) div 2,
    case TargetIndex =< Mid of
        true ->
            % Target index is in the left child's range
            NewLeftTree = update(Tree#tree_node.left, CurrentStart, Mid, TargetIndex, NewChar),
            NewRightTree = Tree#tree_node.right, % Right child remains unchanged
            NewNodeVal = merge(NewLeftTree#tree_node.val, NewRightTree#tree_node.val),
            #tree_node{val = NewNodeVal, left = NewLeftTree, right = NewRightTree};
        false ->
            % Target index is in the right child's range
            NewLeftTree = Tree#tree_node.left, % Left child remains unchanged
            NewRightTree = update(Tree#tree_node.right, Mid + 1, CurrentEnd, TargetIndex, NewChar),
            NewNodeVal = merge(NewLeftTree#tree_node.val, NewRightTree#tree_node.val),
            #tree_node{val = NewNodeVal, left = NewLeftTree, right = NewRightTree}
    end.

merge(L_val, R_val) ->
    NewLen = L_val#node_val.len + R_val#node_val.len,

    % Determine if the entire merged segment is homogeneous
    NewChar = case {L_val#node_val.char, R_val#node_val.char} of
                {C, C} when C /= nil -> C;
                _ -> nil
              end,

    % Calculate new prefix length and character
    NewPrefixLen = case {L_val#node_val.char, R_val#node_val.prefix_char} of
                     {C, C} when C /= nil -> L_val#node_val.len + R_val#node_val.prefix_len;
                     _ -> L_val#node_val.prefix_len
                   end,
    NewPrefixChar = L_val#node_val.prefix_char,

    % Calculate new suffix length and character
    NewSuffixLen = case {R_val#node_val.char, L_val#node_val.suffix_char} of
                     {C, C} when C /= nil -> R_val#node_val.len + L_val#node_val.suffix_len;
                     _ -> R_val#node_val.suffix_len
                   end,
    NewSuffixChar = R_val#node_val.suffix_char,

    % Calculate max length potentially spanning across the merge point
    CombinedMaxLen = case L_val#node_val.suffix_char == R_val#node_val.prefix_char of
                       true -> L_val#node_val.suffix_len + R_val#node_val.prefix_len;
                       false -> 0
                     end,

    % The new max_len is the maximum of max_len from left, right, and the combined length
    NewMaxLen = max(L_val#node_val.max_len, max(R_val#node_val.max_len, CombinedMaxLen)),

    #node_val{len = NewLen, char = NewChar,
              prefix_len = NewPrefixLen, prefix_char = NewPrefixChar,
              suffix_len = NewSuffixLen, suffix_char = NewSuffixChar,
              max_len = NewMaxLen}.