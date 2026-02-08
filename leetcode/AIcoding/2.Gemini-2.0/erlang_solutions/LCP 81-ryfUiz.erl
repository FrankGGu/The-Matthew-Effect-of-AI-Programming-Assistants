-module(nand_puzzle).
-export([nand_puzzle/1]).

nand_puzzle(N) ->
  case N of
    0 -> 1;
    1 -> 0
  end.