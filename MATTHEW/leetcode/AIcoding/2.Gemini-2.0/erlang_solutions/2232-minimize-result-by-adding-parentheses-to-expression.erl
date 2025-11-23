-module(minimize_result).
-export([minimize_result/1]).

minimize_result(Expression) ->
  Parts = string:split(Expression, "+", [global]),
  Left = hd(Parts),
  Right = lists:nth(2, Parts),
  LenLeft = length(Left),
  LenRight = length(Right),
  {BestResult, BestExpr} = lists:foldl(
    fun(I, {AccBestResult, AccBestExpr}) ->
      lists:foldl(
        fun(J, {InnerBestResult, InnerBestExpr}) ->
          LeftNumStr = string:substr(Left, 1, I),
          RightNumStr = string:substr(Right, J, LenRight - J + 1),
          LeftRestStr = string:substr(Left, I + 1, LenLeft - I),
          RightRestStr = string:substr(Right, 1, J - 1),
          LeftNum = list_to_integer(LeftNumStr),
          RightNum = list_to_integer(RightNumStr),

          LeftRestVal = case LeftRestStr of
            "" -> 1;
            _ -> list_to_integer(LeftRestStr)
          end,

          RightRestVal = case RightRestStr of
            "" -> 1;
            _ -> list_to_integer(RightRestStr)
          end,

          CurrentResult = LeftRestVal * (LeftNum + RightNum) * RightRestVal,

          if CurrentResult < InnerBestResult then
            {CurrentResult, RightRestStr ++ "(" ++ LeftNumStr ++ "+" ++ RightNumStr ++ ")" ++ LeftRestStr}
          else
            {InnerBestResult, InnerBestExpr}
          end
        end,
        {AccBestResult, AccBestExpr},
        lists:seq(1, LenRight)
      )
    end,
    {infinity, ""},
    lists:seq(1, LenLeft)
  ),
  BestExpr.