-module(jump_game_v).
-export([maxJumps/3]).

maxJumps(Arr, D, Start) ->
    Len = length(Arr),
    Memo = array:new(Len, {fixed, -1}),
    maxJumpsHelper(Arr, D, Start, Memo).

maxJumpsHelper(Arr, D, Start, Memo) ->
    case array:get(Start, Memo) of
        -1 ->
            Len = length(Arr),
            MaxJump = lists:foldl(fun(Dir, Acc) ->
                                          NewPos = Start + Dir,
                                          case (NewPos >= 0) and (NewPos < Len) of
                                              true ->
                                                  ValidJump = isValidJump(Arr, Start, NewPos, Dir, D),
                                                  case ValidJump of
                                                      true ->
                                                          Jumps = maxJumpsHelper(Arr, D, NewPos, Memo),
                                                          max(Acc, Jumps);
                                                      false ->
                                                          Acc
                                                  end;
                                              false ->
                                                  Acc
                                          end
                                  end, 0, [-1, 1]) + 1,
            array:set(Start, MaxJump, Memo),
            MaxJump;
        Val ->
            Val
    end.

isValidJump(Arr, Start, NewPos, Dir, D) ->
    case Dir of
        1 ->
            isValidJumpRight(Arr, Start, NewPos, D);
        -1 ->
            isValidJumpLeft(Arr, Start, NewPos, D)
    end.

isValidJumpRight(Arr, Start, NewPos, D) ->
    isValidJumpRightHelper(Arr, Start + 1, NewPos, D, Arr[Start + 1], Arr[Start]).

isValidJumpRightHelper(Arr, Current, NewPos, D, CurrentVal, StartVal) ->
    case Current =< NewPos of
        true ->
            case Arr[Current] >= StartVal of
                true ->
                    false;
                false ->
                    case Current == NewPos of
                        true ->
                            true;
                        false ->
                            isValidJumpRightHelper(Arr, Current + 1, NewPos, D, Arr[Current + 1], StartVal)
                    end
            end;
        false ->
            true
    end.

isValidJumpLeft(Arr, Start, NewPos, D) ->
    isValidJumpLeftHelper(Arr, Start - 1, NewPos, D, Arr[Start - 1], Arr[Start]).

isValidJumpLeftHelper(Arr, Current, NewPos, D, CurrentVal, StartVal) ->
    case Current >= NewPos of
        true ->
            case Arr[Current] >= StartVal of
                true ->
                    false;
                false ->
                    case Current == NewPos of
                        true ->
                            true;
                        false ->
                            isValidJumpLeftHelper(Arr, Current - 1, NewPos, D, Arr[Current - 1], StartVal)
                    end
            end;
        false ->
            true
    end.