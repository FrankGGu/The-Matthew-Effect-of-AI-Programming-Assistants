-module(solution).
-export([min_number_of_semesters/3]).

-spec count_set_bits(integer()) -> integer().
count_set_bits(N) when N == 0 -> 0;
count_set_bits(N) ->
    count_set_bits(N band (N - 1)) + 1.

-spec min_number_of_semesters(integer(), list(), integer()) -> integer().
min_number_of_semesters(N, Relations, K) ->
    % Step 1: Precompute prerequisite masks for each course
    % PrereqMasks[i] will be a bitmask of prerequisites for course i (0-indexed)
    PrereqMasks = array:new({size, N}, {default, 0}),
    PrereqMasks1 = lists:foldl(fun([Prev, Next], Acc) ->
                                   CourseIdx = Next - 1,
                                   PrereqIdx = Prev - 1,
                                   array:set(CourseIdx, array:get(CourseIdx, Acc) bor (1 bsl PrereqIdx), Acc)
                               end, PrereqMasks, Relations),

    % Step 2: Precompute total prerequisites for any set of courses (mask)
    % PrereqForSet[mask] will be the union of prereq_masks for all courses in 'mask'
    PrereqForSet = array:new({size, 1 bsl N}, {default, 0}),
    PrereqForSet1 = array:set(0, 0, PrereqForSet), % Base case for empty set
    PrereqForSet2 = lists:foldl(fun(Mask, Acc) ->
                                    if Mask == 0 -> Acc;
                                       true ->
                                            LsbIdx = erlang:log2(Mask band -Mask), % Index of least significant bit
                                            PrevMask = Mask bxor (1 bsl LsbIdx),
                                            Val = array:get(PrevMask, Acc) bor array:get(LsbIdx, PrereqMasks1),
                                            array:set(Mask, Val, Acc)
                                    end
                                end, PrereqForSet1, lists:seq(1, (1 bsl N) - 1)),

    % Step 3: Dynamic Programming (O(3^N) approach)
    % dp[mask] = minimum number of months to complete courses in 'mask'
    % Initialize dp with a large value (infinity)
    Infinity = N + 1, % Max possible months is N, so N+1 is a safe infinity value
    DP = array:new({size, 1 bsl N}, {default, Infinity}),
    DP1 = array:set(0, 0, DP), % 0 months for 0 courses

    FinalDP = lists:foldl(fun(Mask, CurrentDP) ->
                              if Mask == 0 -> CurrentDP; % Skip mask 0, already handled
                                 true ->
                                     % CurrentMinMonths will store the minimum months to reach 'Mask'
                                     % during the iteration of its submasks.
                                     CurrentMinMonths = array:get(Mask, CurrentDP),

                                     % Iterate through all non-empty subsets 'S' of 'Mask'
                                     % 'S' represents courses taken in the *last* month to reach 'Mask'
                                     UpdatedMinMonths = iterate_submasks(Mask, Mask, K, PrereqForSet2, CurrentDP, CurrentMinMonths, N),
                                     array:set(Mask, UpdatedMinMonths, CurrentDP)
                              end
                          end, DP1, lists:seq(1, (1 bsl N) - 1)),

    array:get((1 bsl N) - 1, FinalDP).

-spec iterate_submasks(integer(), integer(), integer(), array:array(), array:array(), integer(), integer()) -> integer().
iterate_submasks(0, _Mask, _K, _PrereqForSet2, _CurrentDP, AccMinMonths, _N) ->
    % Submask 0 means no courses taken in the last month, which is not allowed.
    AccMinMonths;
iterate_submasks(S, Mask, K, PrereqForSet2, CurrentDP, AccMinMonths, N) ->
    NewAccMinMonths =
        if (count_set_bits(S) =< K) ->
            PrevMask = Mask bxor S,
            NeededPrereqs = array:get(S, PrereqForSet2),
            % Check if all prerequisites for courses in 'S' are met by 'PrevMask'
            if (NeededPrereqs band PrevMask) == NeededPrereqs ->
                PrevMonths = array:get(PrevMask, CurrentDP),
                if PrevMonths /= N + 1 -> % Check if prev_mask is reachable
                    erlang:min(AccMinMonths, PrevMonths + 1);
                true -> AccMinMonths
                end;
            true -> AccMinMonths
            end;
        true -> AccMinMonths
        end,
    iterate_submasks((S - 1) band Mask, Mask, K, PrereqForSet2, CurrentDP, NewAccMinMonths, N).