-module(all_possible_fbt).
-export([allPossibleFBT/1]).

allPossibleFBT(N) ->
  allPossibleFBT_helper(N, []).

allPossibleFBT_helper(N, Memo) ->
  case N rem 2 of
    0 ->
      [];
    1 ->
      case lists:get(N, Memo, undefined) of
        undefined ->
          case N of
            1 ->
              Result = [{tree, 1, [], []}];
            _ ->
              Result = lists:foldl(
                         fun(X, Acc) ->
                           Y = N - 1 - X,
                           LeftTrees = allPossibleFBT_helper(X, Memo),
                           RightTrees = allPossibleFBT_helper(Y, Memo),
                           lists:foldl(
                             fun(LeftTree, Acc2) ->
                               lists:foldl(
                                 fun(RightTree, Acc3) ->
                                   [{tree, 1, LeftTree, RightTree} | Acc3]
                                 end,
                                 Acc2,
                                 RightTrees
                               )
                             end,
                             Acc,
                             LeftTrees
                           )
                         end,
                         [],
                         lists:seq(1, N - 2, 2)
                       );
          end,
          Memo2 = lists:keystore(N, 1, Memo, {N, Result}),
          Result;
        Trees ->
          Trees
      end
  end.