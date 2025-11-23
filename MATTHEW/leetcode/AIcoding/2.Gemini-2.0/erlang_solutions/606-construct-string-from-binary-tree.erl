-module(solution).
-export([tree2str/1]).

-spec tree2str(TreeNode()) -> unicode:unicode_binary().

tree2str(null) ->
  "".

tree2str(TreeNode{val = Val, left = Left, right = Right}) ->
  IntegerString = integer_to_list(Val),
  LeftString =
    case Left of
      null ->
        case Right of
          null -> "";
          _ -> "()"
        end;
      _ ->
        "(" ++ tree2str(Left) ++ ")"
    end,
  RightString =
    case Right of
      null -> "";
      _ -> "(" ++ tree2str(Right) ++ ")"
    end,
  unicode:characters_to_binary(IntegerString ++ LeftString ++ RightString).