-module(minimum_swaps).
-export([min_swaps/1]).

min_swaps(Binary) ->
    Ones = lists:filter(fun(X) -> X =:= 1 end, Binary),
    CountOnes = length(Ones),
    ExtendedBinary = Binary ++ Binary,
    SlidingWindow = lists:sublist(ExtendedBinary, 0, length(Binary)),
    MaxOnesInWindow = lists:max(lists:map(fun(Window) -> length(lists:filter(fun(X) -> X =:= 1 end, Window)) end, 
                                                        lists:sublist(ExtendedBinary, 0, length(ExtendedBinary) - CountOnes + 1))),
    CountOnes - MaxOnesInWindow.