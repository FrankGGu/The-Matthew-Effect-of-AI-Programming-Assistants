-module(solution).
-export([getTargetCopy/3]).

getTargetCopy(Original, Cloned, Target) ->
    getTargetCopyHelper(Original, Cloned, Target).

getTargetCopyHelper(Original, Cloned, Target) ->
    case Original of
        null ->
            null;
        _ ->
            if Original =:= Target then
                Cloned
            else
                LeftResult = getTargetCopyHelper(getLeft(Original), getLeft(Cloned), Target),
                if LeftResult =/= null then
                    LeftResult
                else
                    getTargetCopyHelper(getRight(Original), getRight(Cloned), Target)
                end
            end
    end.

getLeft(Node) ->
    case Node of
        null ->
            null;
        {Val, Left, Right} ->
            Left
    end.

getRight(Node) ->
    case Node of
        null ->
            null;
        {Val, Left, Right} ->
            Right
    end.