-module(solution).
-export([countSpecialCharacters/1]).

countSpecialCharacters(S) ->
    % Step 1: Process the string to find the first and last occurrences of each character.
    % We use a map to store these statistics.
    % The map structure will be:
    % #{ CharCode => #{first => FirstIndex, last => LastIndex} }
    % CharCode can be either lowercase or uppercase.
    InitialCharStats = #{},
    IndexedS = lists:zip(S, lists:seq(0, length(S) - 1)),
    CharStats = lists:foldl(
        fun({Char, Index}, Acc) ->
            CurrentStats = maps:get(Char, Acc, #{}),
            NewStats = case CurrentStats of
                #{} -> #{first => Index, last => Index}; % First time seeing this character
                #{first := First, last := Last} -> % Update first and last indices
                    #{first => min(First, Index), last => max(Last, Index)}
            end,
            maps:put(Char, NewStats, Acc)
        end,
        InitialCharStats,
        IndexedS
    ),

    % Step 2: Iterate through each lowercase character from 'a' to 'z'
    % and check if it meets the "special" criteria.
    Count = lists:foldl(
        fun(CharCode, Acc) ->
            LowerChar = CharCode,
            UpperChar = CharCode - 32, % Convert lowercase ASCII to uppercase ASCII

            % Retrieve stats for both lowercase and uppercase versions
            LowerCharEntry = maps:get(LowerChar, CharStats, undefined),
            UpperCharEntry = maps:get(UpperChar, CharStats, undefined),

            case {LowerCharEntry, UpperCharEntry} of
                {undefined, _} -> Acc; % Lowercase character not found in string
                {_, undefined} -> Acc; % Uppercase character not found in string
                {#{first := _, last := MaxLower}, #{first := MinUpper, last := _}} ->
                    % Both lowercase and uppercase exist. Check the condition:
                    % all occurrences of the lowercase character appear before all
                    % occurrences of the uppercase character.
                    % This means the maximum index of the lowercase character must be
                    % less than the minimum index of the uppercase character.
                    if MaxLower < MinUpper -> Acc + 1;
                       true -> Acc
                    end
            end
        end,
        0, % Initial count of special characters
        lists:seq($a, $z) % Iterate through ASCII codes for 'a' to 'z'
    ),
    Count.