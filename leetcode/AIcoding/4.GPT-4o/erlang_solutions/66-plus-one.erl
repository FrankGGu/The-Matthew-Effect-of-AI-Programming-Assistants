-spec plus_one(Digits :: [integer()]) -> [integer()].
plus_one(Digits) ->
    plus_one(Digits, 1).

plus_one([], 0) -> [];
plus_one([9 | Tail], 1) -> 
    [0 | plus_one(Tail, 1)];
plus_one([Digit | Tail], 0) -> 
    [Digit | Tail];
plus_one([Digit | Tail], 1) ->
    [Digit + 1 | Tail].
