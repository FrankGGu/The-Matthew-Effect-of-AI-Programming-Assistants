-module(solution).
-export([isSameTree/2]).

isSameTree(nil, nil) ->
    true;
isSameTree(nil, _) ->
    false;
isSameTree(_, nil) ->
    false;
isSameTree({ValP, LeftP, RightP}, {ValQ, LeftQ, RightQ}) ->
    ValP == ValQ andalso
    isSameTree(LeftP, LeftQ) andalso
    isSameTree(RightP, RightQ).