-module(cousins_in_binary_tree_ii).
-export([replace_value_in_tree/1]).

-spec replace_value_in_tree(TreeNode::tree_node()) -> tree_node().
replace_value_in_tree(Root) ->
    replace_value_in_tree(Root, [ [Root] ]).

replace_value_in_tree(Root, []) ->
    Root;
replace_value_in_tree(Root, [Level | Rest]) ->
    NextLevel = lists:foldl(fun(Node, Acc) ->
                                      case Node of
                                          null -> Acc;
                                          {Val, Left, Right} ->
                                              [Left, Right | Acc]
                                      end
                              end, [], Level),
    LevelSum = lists:sum([case Node of
                               null -> 0;
                               {Val, _, _} -> Val
                           end || Node <- Level]),
    NewLevel = lists:map(fun(Node) ->
                                  case Node of
                                      null -> null;
                                      {Val, Left, Right} ->
                                          SiblingsSum = LevelSum - Val,
                                          {SiblingsSum, Left, Right}
                                  end
                          end, Level),
    replace_value_in_tree(Root, [NextLevel | Rest]).

-type tree_node() :: null | {integer(), tree_node(), tree_node()}.