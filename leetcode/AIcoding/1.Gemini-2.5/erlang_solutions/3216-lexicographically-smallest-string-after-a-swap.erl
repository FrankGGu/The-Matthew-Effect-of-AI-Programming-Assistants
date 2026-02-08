-module(solution).
-export([smallestString/1]).

is_even(Char) ->
    (Char - $0) rem 2 == 0.

smallestString(S) ->
    %% The core logic is a bubble sort with a custom comparison rule:
    %% Two adjacent digits s[i] and s[i+1] can swap if they have different parity.
    %% If they can swap and s[i] > s[i+1], we perform the swap to achieve
    %% lexicographically smallest order.
    %% We repeat passes until no swaps are made in an entire pass.

    %% Loop function for repeated passes of bubble sort.
    %% It takes the current list of characters and performs one pass.
    %% If a swap occurred, it calls itself with the new list.
    %% If no swaps occurred, the list is sorted according to the rules, and it returns the list.
    Loop = fun F(CurrentList) ->
        {NextList, SwappedInThisPass} = one_bubble_pass(CurrentList),
        case SwappedInThisPass of
            true -> F(NextList); % Swaps occurred, continue with another pass
            false -> NextList    % No swaps, the list is finalized
        end
    end,

    %% Start the loop with the initial string (which is already a list of characters in Erlang).
    Loop(S).

one_bubble_pass(RemainingInput) ->
    one_bubble_pass(RemainingInput, [], false).

one_bubble_pass([C1, C2 | Rest], Acc, SwappedAcc) ->
    P1 = is_even(C1),
    P2 = is_even(C2),

    case P1 =/= P2 andalso C1 > C2 of
        true ->
            %% Different parities and C1 > C2, so swap them.
            %% C2 (the smaller digit) moves left, so it's added to the accumulator.
            %% C1 (the larger digit) moves right, so it becomes the head of the
            %% RemainingInput for the next comparison with the element from Rest.
            one_bubble_pass([C1 | Rest], [C2 | Acc], true);
        false ->
            %% No swap (either same parity or C1 < C2).
            %% C1 stays in its position (added to accumulator).
            %% C2 becomes the head of the RemainingInput for the next comparison.
            one_bubble_pass([C2 | Rest], [C1 | Acc], SwappedAcc)
    end;

one_bubble_pass([C | []], Acc, SwappedAcc) ->
    %% Base case: only one element left in RemainingInput.
    %% Add it to the accumulator and reverse the entire accumulated list.
    {lists:reverse([C | Acc]), SwappedAcc};

one_bubble_pass([], Acc, SwappedAcc) ->
    %% Base case: RemainingInput is empty.
    %% Reverse the accumulated list to get the correct order.
    {lists:reverse(Acc), SwappedAcc}.