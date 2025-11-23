-module(solution).
-export([longestAwesome/1]).

longestAwesome(S) ->
    % Acc = {CurrentMask, Map, MaxLen, CurrentIndex}
    % Map stores #{mask => first_index}
    % CurrentIndex is the 0-based index *before* processing the current character.
    % So, J (1-based index of current character) = CurrentIndex + 1.
    % Initial state:
    % CurrentMask = 0 (for the empty prefix before index 0)
    % Map = #{0 => 0} (mask 0 is seen at index 0)
    % MaxLen = 0 (initial longest awesome substring length)
    % CurrentIndex = 0 (before processing the first character, which will be at J=1)

    {_FinalMask, _FinalMap, MaxLen, _FinalIndex} = lists:foldl(
        fun(Char, {CurrentMaskAcc, MapAcc, MaxLenAcc, IndexAcc}) ->
            J = IndexAcc + 1, % Current 1-based index of the character being processed
            Digit = Char - $0, % Convert character '0'-'9' to integer 0-9
            NewCurrentMask = CurrentMaskAcc bxor (1 bsl Digit), % Update mask by flipping the bit for the current digit

            % Calculate MaxLen based on two conditions for an "awesome" substring:
            % 1. The substring's mask is 0 (all digits appear an even number of times).
            %    This means NewCurrentMask == MapAcc_Value (where MapAcc_Value is prefix_mask[i]).
            %    So, NewCurrentMask xor MapAcc_Value == 0.
            NewMaxLen1 = case maps:find(NewCurrentMask, MapAcc) of
                {ok, PrevIdx} -> max(MaxLenAcc, J - PrevIdx);
                error -> MaxLenAcc
            end,

            % 2. The substring's mask has exactly one bit set (exactly one digit appears an odd number of times).
            %    This means NewCurrentMask xor MapAcc_Value == (1 bsl K) for some K in 0..9.
            %    So, MapAcc_Value == NewCurrentMask xor (1 bsl K).
            NewMaxLen2 = lists:foldl(
                fun(K, AccLen) ->
                    TargetMask = NewCurrentMask bxor (1 bsl K),
                    case maps:find(TargetMask, MapAcc) of
                        {ok, PrevIdx} -> max(AccLen, J - PrevIdx);
                        error -> AccLen
                    end
                end,
                NewMaxLen1, % Start with the max length found from condition 1
                lists:seq(0, 9) % Iterate through all possible single-bit flips
            ),

            % Add NewCurrentMask to Map if it's not already present.
            % We store the *first* occurrence of each mask to ensure we find the *longest* substring.
            NewMap = case maps:is_key(NewCurrentMask, MapAcc) of
                true -> MapAcc;
                false -> maps:put(NewCurrentMask, J, MapAcc)
            end,

            % Return the updated accumulator for the next iteration
            {NewCurrentMask, NewMap, NewMaxLen2, J}
        end,
        {0, #{0 => 0}, 0, 0}, % Initial accumulator
        S % The input string (list of characters)
    ),
    MaxLen. % Extract the final maximum length