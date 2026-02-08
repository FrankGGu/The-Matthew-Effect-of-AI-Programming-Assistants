-module(solution).
-export([insertIntoMaxTree/2]).

insertIntoMaxTree(nil, Val) ->
    {Val, nil, nil};
insertIntoMaxTree({RootVal, Left, Right}, Val) when Val > RootVal ->
    {Val, {RootVal, Left, Right}, nil};
insertIntoMaxTree({RootVal, Left, Right}, Val) ->
    %% Since all values are unique, if Val is not greater than RootVal,
    %% it must be less than RootVal.
    {RootVal, Left, insertIntoMaxTree(Right, Val)}.