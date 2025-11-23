-module(solution).
-export([minimum_deletions/1]).

minimum_deletions(S) ->
    % First, count total 'a's in the string. This is needed to initialize A_count_right.
    TotalA = lists:foldl(fun(Char, Acc) ->
                                 case Char of
                                     $a -> Acc + 1;
                                     _ -> Acc
                                 end
                         end, 0, S),

    % Initial state for lists:foldl:
    % {B_count_in_prefix, A_count_in_suffix, Min_deletions_found_so_far}
    %
    % B_count_in_prefix: Number of 'b's in the part of the string to the left of the current split point.
    % A_count_in_suffix: Number of 'a's in the part of the string to the right of the current split point.
    % Min_deletions_found_so_far: The minimum deletions found for any split point considered so far.
    %
    % The initial split point is before the first character (index 0).
    % This means the entire string is considered to be 'b's.
    % So, B_count_in_prefix = 0, A_count_in_suffix = TotalA.
    % The cost for this split point is 0 + TotalA = TotalA.
    InitialState = {0, TotalA, TotalA},

    % Iterate through the string, considering each character as a potential split point.
    % The foldl function processes each character S[i].
    % On entry to the fun, B_left is count of 'b's in S[0...i-1], A_right is count of 'a's in S[i...N-1].
    % This represents the split point at index i.
    {FinalB_left, _FinalA_right, MinDeletionsFromFold} = lists:foldl(fun(Char, {B_left, A_right, CurrentMin}) ->
                                                             % Calculate the cost for the current split point (at index i).
                                                             % This is (b's in S[0...i-1]) + (a's in S[i...N-1]).
                                                             Cost = B_left + A_right,
                                                             UpdatedMin = min(CurrentMin, Cost),

                                                             % Update B_left and A_right for the next iteration (split point at index i+1).
                                                             % S[i] moves from the 'right' part to the 'left' part.
                                                             NewB_left = case Char of
                                                                             $b -> B_left + 1;
                                                                             _ -> B_left
                                                                         end,
                                                             NewA_right = case Char of
                                                                              $a -> A_right - 1;
                                                                              _ -> A_right
                                                                          end,
                                                             {NewB_left, NewA_right, UpdatedMin}
                                                     end, InitialState, S),

    % After the loop, MinDeletionsFromFold contains the minimum deletions for split points 0 to N-1.
    % We also need to consider the split point at N (after the last character).
    % This case assumes the entire string is 'a's.
    % At this point, FinalB_left will be the total count of 'b's in the string.
    % FinalA_right will be 0.
    % The cost for this split point is FinalB_left + 0 (which is TotalB_count).
    min(MinDeletionsFromFold, FinalB_left).