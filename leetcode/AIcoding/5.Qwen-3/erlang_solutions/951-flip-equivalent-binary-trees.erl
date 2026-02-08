-module(flip_equivalent_binary_trees).
-export([flipEquiv/2]).

flipEquiv(A, B) ->
    flipEquivHelper(A, B).

flipEquivHelper(nil, nil) -> true;
flipEquivHelper(nil, _) -> false;
flipEquivHelper(_, nil) -> false;
flipEquivHelper({ValA, LeftA, RightA}, {ValB, LeftB, RightB}) ->
    ValA == ValB andalso
        (flipEquivHelper(LeftA, LeftB) andalso flipEquivHelper(RightA, RightB) orelse
         flipEquivHelper(LeftA, RightB) andalso flipEquivHelper(RightA, LeftB)).