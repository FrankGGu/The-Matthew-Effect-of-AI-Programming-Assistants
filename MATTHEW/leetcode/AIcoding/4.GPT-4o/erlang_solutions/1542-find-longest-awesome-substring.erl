-module(solution).
-export([longest_awesome/1]).

longest_awesome(S) ->
    Length = string:len(S),
    Prefix = lists:duplicate(1024, 0),
    PrefixCount = 1,
    MaxLength = 0,
    State = 0,
    lists:foldl(fun(Char, {MaxLength, State, Prefix, PrefixCount}) ->
        Digit = $0 - Char,
        State = bor(State, bsl(1, Digit)),
        Index = lists:nth(State + 1, Prefix),
        NewMaxLength = case Index of
            0 -> MaxLength;
            _ -> max(MaxLength, PrefixCount - Index)
        end,
        Prefix = lists:update_element(State + 1, PrefixCount, Prefix),
        {NewMaxLength, State, Prefix, PrefixCount + 1}
    end, {MaxLength, State, Prefix, PrefixCount}, string:to_list(S))#{
        1 => fun(State) -> MaxLength + (1 - (band(State, bor(State, bsr(State, 1))))) end
    }(State).