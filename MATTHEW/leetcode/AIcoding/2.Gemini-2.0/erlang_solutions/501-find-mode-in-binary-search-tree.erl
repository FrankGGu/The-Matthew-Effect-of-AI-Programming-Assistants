-module(find_mode_bst).
-export([find_mode/1]).

find_mode(Root) ->
  {_, Modes} = in_order(Root, {[], 0, undefined, []}),
  Modes.

in_order(null, Acc) ->
  Acc;
in_order(Node, {Modes, MaxCount, PrevVal, CurrentModes}) ->
  {LeftModes, LeftMaxCount, LeftPrevVal, LeftCurrentModes} = in_order(Node.left, {[], 0, undefined, []}),

  {NewModes, NewMaxCount, NewPrevVal, NewCurrentModes} =
    case Node.val of
      LeftPrevVal ->
        NewCount = 
          case LeftPrevVal of
            undefined -> 1;
            _ -> LeftMaxCount + 1
          end,
        case NewCount > LeftMaxCount of
          true -> {[Node.val], NewCount, Node.val, [Node.val]};
          false ->
            case NewCount == LeftMaxCount of
              true -> {LeftModes ++ [Node.val], LeftMaxCount, Node.val, LeftCurrentModes ++ [Node.val]};
              false -> {LeftModes, LeftMaxCount, Node.val, LeftCurrentModes}
            end
        end;
      _ ->
        case LeftMaxCount == 0 of
          true -> {[Node.val], 1, Node.val, [Node.val]};
          false ->
            case 1 > LeftMaxCount of
              true -> {[Node.val], 1, Node.val, [Node.val]};
              false ->
                case 1 == LeftMaxCount of
                  true -> {LeftModes ++ [Node.val], LeftMaxCount, Node.val, LeftCurrentModes ++ [Node.val]};
                  false -> {LeftModes, LeftMaxCount, Node.val, LeftCurrentModes}
                end
            end
        end
    end,

  {RightModes, RightMaxCount, RightPrevVal, RightCurrentModes} = in_order(Node.right, {[], 0, NewPrevVal, []}),

  NewModes2 =
    case NewMaxCount > RightMaxCount of
      true -> NewModes;
      false ->
        case NewMaxCount == RightMaxCount of
          true -> lists:usort(NewModes ++ RightModes);
          false -> RightModes
        end
    end,

  MaxCount2 = max(NewMaxCount, RightMaxCount),

  {NewModes2, MaxCount2}.