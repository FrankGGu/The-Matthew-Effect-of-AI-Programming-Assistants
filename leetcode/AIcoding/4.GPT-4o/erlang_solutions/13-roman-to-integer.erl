-spec roman_to_int(S :: unicode:unicode_binary()) -> integer().
roman_to_int(S) ->
    roman_to_int(S, 0, 0).

roman_to_int([], Result, _) -> Result;
roman_to_int([H | T], Result, PrevValue) ->
    Value = roman_value(H),
    NewResult = if
                  Value < PrevValue -> Result - Value;
                  true -> Result + Value
                end,
    roman_to_int(T, NewResult, Value).

roman_value(73) -> 1;    % 'I'
roman_value(86) -> 5;    % 'V'
roman_value(88) -> 10;   % 'X'
roman_value(76) -> 50;   % 'L'
roman_value(67) -> 100;  % 'C'
roman_value(68) -> 500;  % 'D'
roman_value(77) -> 1000; % 'M'
