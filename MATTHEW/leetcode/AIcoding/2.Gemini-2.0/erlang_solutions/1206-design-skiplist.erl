-module(skiplist).
-export([new/0, add/2, erase/2, search/2]).

-record(node, {val, forward = []}).
-record(skiplist, {head, level = 0, probability = 0.5}).

new() ->
    Head = #node{val = -1, forward = []},
    #skiplist{head = Head}.

add(SkipList, Num) ->
    add(SkipList, Num, SkipList#skiplist.level).

add(SkipList, Num, Level) ->
    update(SkipList, Num, Level, []).

update(SkipList, Num, Level, UpdateList) ->
    Update = lists:duplicate(Level + 1, undefined),

    {NewHead, NewLevel} = find_update(SkipList#skiplist.head, Num, SkipList#skiplist.level, Update, 0),

    RandLevel = random_level(SkipList#skiplist.probability),

    NewSkipListLevel = max(NewLevel, RandLevel),

    NewSkipList = SkipList#skiplist{level = NewSkipListLevel},

    NewUpdate = lists:duplicate(NewSkipListLevel + 1, undefined),
    NewUpdateList = lists:sublist(Update, 1, min(length(Update), NewSkipListLevel + 1)),
    NewUpdateListWithPadding = NewUpdateList ++ lists:duplicate(NewSkipListLevel + 1 - length(NewUpdateList), undefined),

    lists:zipwith(fun(X, Y) ->
                          case X of
                              undefined -> NewHead;
                              _ -> X
                          end
                  end, NewUpdateListWithPadding, lists:seq(1, NewSkipListLevel + 1)),

    NewNode = #node{val = Num, forward = lists:duplicate(NewSkipListLevel + 1, undefined)},

    NewNodeWithForward = lists:zipwith(fun(X, _) ->
                                              case X of
                                                  undefined -> nil;
                                                  _ -> X#node.forward
                                              end
                                      end, NewUpdateListWithPadding, lists:seq(1, NewSkipListLevel + 1)),

    lists:zipwith(fun(Node, Forward) ->
                          case Node of
                              nil -> nil;
                              _ ->
                                  case Forward of
                                      nil -> nil;
                                      _ ->
                                          Node
                                  end
                          end
                  end, NewNodeWithForward, lists:seq(1, NewSkipListLevel + 1)),

    FinalNode = #node{val = Num, forward = [case X of
                                                  undefined -> nil;
                                                  _ -> X
                                              end || X <- [case Y of
                                                              undefined -> nil;
                                                              _ -> Y
                                                          end || Y <- lists:zipwith(fun(U, _) ->
                                                                                      get_forward(U, Num)
                                                                                  end, NewUpdateListWithPadding, lists:seq(1, NewSkipListLevel + 1))]
                                              ]},

    lists:zipwith(fun(Node, Level2) ->
                          case Node of
                              undefined -> nil;
                              _ ->
                                  Node#node{forward = lists:put_at(Level2 + 1, FinalNode, Node#node.forward)}
                          end
                  end, NewUpdateListWithPadding, lists:seq(0, NewSkipListLevel)),

    ok.

get_forward(Node, Num) ->
    try
        case lists:nth(1, Node#node.forward) of
            nil ->
                nil;
            NextNode ->
                if NextNode#node.val < Num then
                    NextNode#node.forward
                else
                    Node#node.forward
                end
        end
    catch
        _:_ ->
            nil
    end.

find_update(Node, Num, Level, Update, CurrentLevel) ->
    if Level < 0 then
        {Node, Level}
    else
        case lists:nth(Level + 1, Node#node.forward) of
            nil ->
                lists:put_at(Level + 1, Node, Update),
                find_update(Node, Num, Level - 1, Update, CurrentLevel + 1);
            NextNode ->
                if NextNode#node.val < Num then
                    find_update(NextNode, Num, Level, Update, CurrentLevel + 1)
                else
                    UpdateList = lists:put_at(Level + 1, Node, Update),
                    find_update(Node, Num, Level - 1, UpdateList, CurrentLevel + 1)
                end
        end
    end.

random_level(Probability) ->
    random_level(Probability, 0).

random_level(Probability, Level) ->
    case rand:uniform() < Probability of
        true ->
            random_level(Probability, Level + 1);
        false ->
            Level
    end.

erase(SkipList, Num) ->
    erase(SkipList, Num, SkipList#skiplist.level).

erase(SkipList, Num, Level) ->
    update_erase(SkipList, Num, Level, []).

update_erase(SkipList, Num, Level, UpdateList) ->
    Update = lists:duplicate(Level + 1, undefined),

    {NewHead, NewLevel} = find_update(SkipList#skiplist.head, Num, SkipList#skiplist.level, Update, 0),

    NewUpdate = lists:duplicate(Level + 1, undefined),
    NewUpdateList = lists:sublist(Update, 1, min(length(Update), Level + 1)),
    NewUpdateListWithPadding = NewUpdateList ++ lists:duplicate(Level + 1 - length(NewUpdateList), undefined),

    lists:zipwith(fun(X, Y) ->
                          case X of
                              undefined -> NewHead;
                              _ -> X
                          end
                  end, NewUpdateListWithPadding, lists:seq(1, Level + 1)),

    lists:zipwith(fun(Node, Level2) ->
                          case Node of
                              undefined -> nil;
                              _ ->
                                  case lists:nth(Level2 + 1, Node#node.forward) of
                                      nil -> nil;
                                      TargetNode ->
                                          if TargetNode#node.val == Num then
                                              try
                                                  NewForward = lists:nth(Level2 + 1, TargetNode#node.forward);
                                                  Node#node{forward = lists:put_at(Level2 + 1, NewForward, Node#node.forward)}
                                              catch
                                                  _:_ ->
                                                      Node#node{forward = lists:put_at(Level2 + 1, nil, Node#node.forward)}
                                              end
                                          else
                                              Node
                                          end
                                  end
                          end
                  end, NewUpdateListWithPadding, lists:seq(0, Level)),

    ok.

search(SkipList, Num) ->
    search(SkipList, Num, SkipList#skiplist.head, SkipList#skiplist.level).

search(SkipList, Num, Node, Level) ->
    if Level < 0 then
        false
    else
        case lists:nth(Level + 1, Node#node.forward) of
            nil ->
                search(SkipList, Num, Node, Level - 1);
            NextNode ->
                if NextNode#node.val == Num then
                    true
                elseif NextNode#node.val < Num then
                    search(SkipList, Num, NextNode, Level)
                else
                    search(SkipList, Num, Node, Level - 1)
                end
        end
    end.