-module(solution).
-export([can_transform/2]).

-spec can_transform(Start :: unicode:unicode_binary(), Target :: unicode:unicode_binary()) -> boolean().
can_transform(Start, Target) ->
    Len = byte_size(Start),
    can_transform_impl(Start, Target, Len, 0, 0).

can_transform_impl(Start, Target, Len, I, J) ->
    % Advance I to the next non-underscore char in Start
    NI = skip_underscores(Start, Len, I),
    % Advance J to the next non-underscore char in Target
    NJ = skip_underscores(Target, Len, J),

    if
        NI == Len andalso NJ == Len ->
            % Both pointers reached the end, all non-underscore chars matched
            true;
        NI == Len orelse NJ == Len ->
            % One reached the end, but the other didn't.
            % This means a mismatch in the count or sequence of non-underscore characters.
            false;
        true ->
            % Both pointers found non-underscore characters
            StartChar = binary:at(Start, NI),
            TargetChar = binary:at(Target, NJ),

            % The non-underscore characters must be identical
            if
                StartChar /= TargetChar ->
                    false;
                StartChar == $L ->
                    % 'L' can only move left. Its starting index NI must be >= its target index NJ.
                    % If NI < NJ, it means 'L' would have to move right, which is impossible.
                    if
                        NI < NJ -> false;
                        true -> can_transform_impl(Start, Target, Len, NI + 1, NJ + 1)
                    end;
                StartChar == $R ->
                    % 'R' can only move right. Its starting index NI must be <= its target index NJ.
                    % If NI > NJ, it means 'R' would have to move left, which is impossible.
                    if
                        NI > NJ -> false;
                        true -> can_transform_impl(Start, Target, Len, NI + 1, NJ + 1)
                    end
            end
    end.

skip_underscores(Binary, Len, Index) ->
    if
        Index < Len andalso binary:at(Binary, Index) == $_ ->
            skip_underscores(Binary, Len, Index + 1);
        true ->
            Index
    end.