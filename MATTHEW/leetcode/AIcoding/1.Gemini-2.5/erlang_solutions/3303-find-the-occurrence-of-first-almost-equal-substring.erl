-module(solution).
-export([find_first_almost_equal_substring/3]).

find_first_almost_equal_substring(Text, Pattern, K) ->
    PatternLen = length(Pattern),
    % Handle empty pattern case: an empty pattern is considered to match at index 0.
    if PatternLen == 0 ->
        0;
    true ->
        find_first_almost_equal_substring_recursive(Text, Pattern, K, 0, PatternLen)
    end.

find_first_almost_equal_substring_recursive(Text_Current, Pattern, K, CurrentIndex, PatternLen) ->
    case Text_Current of
        [] ->
            % If Text_Current is empty, no more matches are possible.
            -1;
        _ ->
            % Check if the current prefix of Text_Current (of length PatternLen) is almost equal to Pattern.
            case is_almost_equal_prefix(Text_Current, Pattern, K, PatternLen) of
                true ->
                    CurrentIndex; % Found a match at CurrentIndex
                false ->
                    % No match, slide the window by moving to the next character in Text_Current.
                    [_|RestOfText] = Text_Current,
                    find_first_almost_equal_substring_recursive(RestOfText, Pattern, K, CurrentIndex + 1, PatternLen)
            end
    end.

is_almost_equal_prefix(_TextPrefix, _Pattern, _K, 0) ->
    % All characters of the pattern have been successfully compared.
    true;
is_almost_equal_prefix([C1|R1], [C2|R2], K, Count) ->
    % Compare current characters
    Diff = abs(C1 - C2),
    case Diff =< K of
        true ->
            % Characters are almost equal, continue with the rest of the strings.
            is_almost_equal_prefix(R1, R2, K, Count - 1);
        false ->
            % Characters are not almost equal, so the prefix is not a match.
            false
    end;
is_almost_equal_prefix(_TextPrefix, _Pattern, _K, _Count) ->
    % This clause is reached if TextPrefix runs out of elements before Count reaches 0.
    % This means TextPrefix is shorter than the required PatternLen, so it cannot be a match.
    false.