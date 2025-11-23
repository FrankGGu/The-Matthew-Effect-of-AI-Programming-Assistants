-module(solution).
-export([min_deletion_size/1]).

min_deletion_size(Strs) ->
    N = length(Strs),
    % If there's only one string, it's always sorted (no pairs to compare).
    % According to constraints, N >= 1, so N=0 is not possible.
    if N == 1 ->
        0;
    true ->
        M = length(hd(Strs)),

        % InitialIsEqual is a list of N-1 booleans, all true.
        % InitialIsEqual[K] (0-indexed) is true if Str[K] and Str[K+1] are still equal
        % based on previously kept columns.
        InitialIsEqual = lists:duplicate(N - 1, true),

        % Iterate through columns from 0 to M-1
        % Acc = {DeletedCount, CurrentIsEqual}
        {DeletedCount, _FinalIsEqual} = lists:foldl(
            fun(ColIdx, {AccDeletedCount, CurrentIsEqual}) ->
                % Check if this column can be kept
                CanKeepThisColumn = check_column(ColIdx, Strs, CurrentIsEqual, N),

                if CanKeepThisColumn ->
                    % If kept, update the CurrentIsEqual status for relevant row pairs
                    NewIsEqual = update_is_equal(ColIdx, Strs, CurrentIsEqual, N),
                    {AccDeletedCount, NewIsEqual};
                true ->
                    % If not kept, increment deleted count. CurrentIsEqual status remains unchanged.
                    {AccDeletedCount + 1, CurrentIsEqual}
                end
            end,
            {0, InitialIsEqual},
            lists:seq(0, M - 1)
        ),

        DeletedCount
    end.

check_column(ColIdx, Strs, IsEqual, N) ->
    % Iterate through adjacent row pairs (0 to N-2)
    lists:all(
        fun(RowIdx) ->
            % Only check if the current row pair (RowIdx, RowIdx+1) is still considered equal
            % based on previously kept columns.
            % If they are already strictly sorted, this column cannot break that.
            if lists:nth(RowIdx + 1, IsEqual) -> % IsEqual is 1-indexed for lists:nth
                % Get characters for current column at RowIdx and RowIdx+1
                % Strs is 1-indexed for outer list, then 1-indexed for inner string
                Char1 = lists:nth(ColIdx + 1, lists:nth(RowIdx + 1, Strs)),
                Char2 = lists:nth(ColIdx + 1, lists:nth(RowIdx + 2, Strs)),
                % Check if Char1 <= Char2
                Char1 =< Char2;
            true ->
                true % This pair is already strictly sorted, so it's fine
            end
        end,
        lists:seq(0, N - 2) % Iterate 0-indexed RowIdx
    ).

update_is_equal(ColIdx, Strs, IsEqual, N) ->
    % Iterate through adjacent row pairs (0 to N-2)
    lists:foldl(
        fun(RowIdx, AccIsEqual) ->
            % Only update if the current row pair (RowIdx, RowIdx+1) was previously equal
            if lists:nth(RowIdx + 1, AccIsEqual) -> % AccIsEqual is 1-indexed for lists:nth
                % Get characters for current column at RowIdx and RowIdx+1
                Char1 = lists:nth(ColIdx + 1, lists:nth(RowIdx + 1, Strs)),
                Char2 = lists:nth(ColIdx + 1, lists:nth(RowIdx + 2, Strs)),

                if Char1 < Char2 -> % If they become strictly sorted by this column
                    % Update IsEqual for this pair to false
                    lists:replace_nth(RowIdx + 1, false, AccIsEqual);
                true -> % If they remain equal (Char1 == Char2)
                    AccIsEqual % No change to IsEqual status for this pair
                end;
            true -> % If already strictly sorted, status doesn't change
                AccIsEqual
            end
        end,
        IsEqual,
        lists:seq(0, N - 2) % Iterate 0-indexed RowIdx
    ).