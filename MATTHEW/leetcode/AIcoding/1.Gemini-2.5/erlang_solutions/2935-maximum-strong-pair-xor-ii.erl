-module(solution).
-export([maximumStrongPairXor/1]).

-define(MAX_BITS, 30).

insert(Trie, Num) ->
    insert_recursive(Trie, Num, ?MAX_BITS).

insert_recursive(nil, Num, Bit) ->
    insert_recursive({node, nil, nil, 0}, Num, Bit);
insert_recursive({node, Left, Right, Count}, Num, Bit) ->
    NewCount = Count + 1,
    if Bit < 0 ->
        {node, Left, Right, NewCount};
    else
        BitVal = (Num bsr Bit) band 1,
        if BitVal == 0 ->
            NewLeft = insert_recursive(Left, Num, Bit - 1),
            {node, NewLeft, Right, NewCount};
        else
            NewRight = insert_recursive(Right, Num, Bit - 1),
            {node, Left, NewRight, NewCount}
        end
    end.

remove(Trie, Num) ->
    remove_recursive(Trie, Num, ?MAX_BITS).

remove_recursive(nil, _Num, _Bit) ->
    nil; % Should not happen if number was inserted and count > 0
remove_recursive({node, Left, Right, Count}, Num, Bit) ->
    NewCount = Count - 1,
    if NewCount == 0 ->
        nil; % If count becomes 0, this path is effectively removed
    else
        if Bit < 0 ->
            {node, Left, Right, NewCount};
        else
            BitVal = (Num bsr Bit) band 1,
            if BitVal == 0 ->
                NewLeft = remove_recursive(Left, Num, Bit - 1),
                {node, NewLeft, Right, NewCount};
            else
                NewRight = remove_recursive(Right, Num, Bit - 1),
                {node, Left, NewRight, NewCount}
            end
        end
    end.

query_max_xor(Trie, Num) ->
    query_max_xor_recursive(Trie, Num, ?MAX_BITS, 0).

query_max_xor_recursive(nil, _Num, _Bit, _CurrentXor) ->
    0; % No path, cannot contribute to XOR
query_max_xor_recursive({node, _Left, _Right, Count}, _Num, _Bit, _CurrentXor) when Count == 0 ->
    0; % Path is empty, cannot contribute
query_max_xor_recursive({node, Left, Right, _Count}, Num, Bit, CurrentXor) ->
    if Bit < 0 ->
        CurrentXor;
    else
        BitVal = (Num bsr Bit) band 1,
        TargetBit = 1 - BitVal, % Try to get the opposite bit for max XOR

        if TargetBit == 0 -> % Try path 0
            % Check if Left child exists and is active (its count > 0)
            if Left /= nil andalso element(4, Left) > 0 ->
                query_max_xor_recursive(Left, Num, Bit - 1, CurrentXor bor (1 bsl Bit));
            else % Must take path 1
                query_max_xor_recursive(Right, Num, Bit - 1, CurrentXor)
            end;
        else % Try path 1
            % Check if Right child exists and is active (its count > 0)
            if Right /= nil andalso element(4, Right) > 0 ->
                query_max_xor_recursive(Right, Num, Bit - 1, CurrentXor bor (1 bsl Bit));
            else % Must take path 0
                query_max_xor_recursive(Left, Num, Bit - 1, CurrentXor)
            end
        end
    end.

maximumStrongPairXor(Nums) ->
    SortedNumsList = lists:sort(Nums),
    SortedNums = array:from_list(SortedNumsList), % Convert to array for O(1) access
    N = array:size(SortedNums),

    InitialTrie = {node, nil, nil, 0}, % Root node with count 0

    loop(SortedNums, N, 0, 0, InitialTrie, 0).

loop(_SortedNums, N, Right, _Left, _Trie, MaxXor) when Right >= N ->
    MaxXor;
loop(SortedNums, N, Right, Left, Trie, CurrentMaxXor) ->
    NumRight = array:get(Right, SortedNums), % array is 0-indexed

    % Adjust Left pointer: remove elements SortedNums[Left] from Trie while SortedNums[Left] < NumRight / 2
    {NewTrie, NewLeft} = adjust_left_pointer(Trie, SortedNums, Left, NumRight, N),

    % Query for max XOR with NumRight against elements currently in Trie
    % Only query if Trie is not empty (i.e., NewTrie's root count > 0)
    QueryXor = if element(4, NewTrie) > 0 ->
                   query_max_xor(NewTrie, NumRight);
               else
                   0
               end,
    UpdatedMaxXor = max(CurrentMaxXor, QueryXor),

    % Insert NumRight into Trie
    FinalTrie = insert(NewTrie, NumRight),

    % Continue to next Right
    loop(SortedNums, N, Right + 1, NewLeft, FinalTrie, UpdatedMaxXor).

adjust_left_pointer(Trie, SortedNums, Left, NumRight, N) ->
    if Left < N ->
        NumLeft = array:get(Left, SortedNums),
        if NumLeft < NumRight div 2 -> % Note: integer division
            RemovedTrie = remove(Trie, NumLeft),
            adjust_left_pointer(RemovedTrie, SortedNums, Left + 1, NumRight, N);
        else
            {Trie, Left}
        end;
    else
        {Trie, Left}
    end.