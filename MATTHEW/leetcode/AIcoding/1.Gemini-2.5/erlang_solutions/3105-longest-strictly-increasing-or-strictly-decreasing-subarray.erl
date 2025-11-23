-module(solution).
-export([longest_subarray/1]).

longest_subarray(Nums) ->
    case Nums of
        [] -> 0;
        [_] -> 0; % A single element cannot form a strictly increasing or decreasing subarray of length >= 2
        [H1 | T] ->
            H2 = hd(T),
            % Initialize current_inc_len and current_dec_len based on the first two elements
            % If H2 > H1, inc_len starts at 2, dec_len at 1
            % If H2 < H1, dec_len starts at 2, inc_len at 1
            % If H2 == H1, both start at 1 (no strictly increasing/decreasing yet)
            InitialIncLen = if H2 > H1 -> 2; else -> 1 end,
            InitialDecLen = if H2 < H1 -> 2; else -> 1 end,

            % Initial MaxLen is determined by the first two elements.
            % Only consider lengths >= 2.
            InitialMaxLen = max_len_update(0, InitialIncLen),
            FinalInitialMaxLen = max_len_update(InitialMaxLen, InitialDecLen),

            % Start recursion with the rest of the list, H2 as the previous element
            longest_subarray_recursive(tl(T), FinalInitialMaxLen, InitialIncLen, InitialDecLen, H2)
    end.

longest_subarray_recursive([], MaxLen, _CurrentIncLen, _CurrentDecLen, _Prev) ->
    MaxLen;
longest_subarray_recursive([H | T], MaxLen, CurrentIncLen, CurrentDecLen, Prev) ->
    % Calculate new lengths for increasing and decreasing subarrays ending at H
    NewIncLen = if H > Prev -> CurrentIncLen + 1; else -> 1 end,
    NewDecLen = if H < Prev -> CurrentDecLen + 1; else -> 1 end,

    % Update MaxLen, only considering lengths >= 2
    UpdatedMaxLen1 = max_len_update(MaxLen, NewIncLen),
    UpdatedMaxLen2 = max_len_update(UpdatedMaxLen1, NewDecLen),

    longest_subarray_recursive(T, UpdatedMaxLen2, NewIncLen, NewDecLen, H).

max_len_update(CurrentMax, NewLen) ->
    if NewLen >= 2 andalso NewLen > CurrentMax ->
        NewLen;
    else ->
        CurrentMax
    end.