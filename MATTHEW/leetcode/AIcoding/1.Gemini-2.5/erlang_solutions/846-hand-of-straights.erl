-module(solution).
-export([isNStraightHand/2]).

isNStraightHand(Hand, GroupSize) ->
    Len = length(Hand),
    if Len rem GroupSize =/= 0 ->
        false;
    true ->
        FreqTree = lists:foldl(
            fun(Card, AccTree) ->
                gb_trees:update(Card, fun(Count) -> Count + 1 end, 1, AccTree)
            end,
            gb_trees:empty(),
            Hand
        ),

        NumGroups = Len div GroupSize,
        check_groups(NumGroups, GroupSize, FreqTree)
    end.

check_groups(0, _GroupSize, _FreqTree) ->
    true;
check_groups(NumGroups, GroupSize, FreqTree) ->
    case gb_trees:smallest(FreqTree) of
        none ->
            false; 
        {MinCard, _Count} ->
            Result = form_one_group(MinCard, GroupSize, FreqTree),
            case Result of
                false ->
                    false;
                NewFreqTree ->
                    check_groups(NumGroups - 1, GroupSize, NewFreqTree)
            end
    end.

form_one_group(StartCard, GroupSize, FreqTree) ->
    form_one_group_recursive(StartCard, StartCard + GroupSize - 1, FreqTree).

form_one_group_recursive(CurrentCard, EndCard, FreqTree) when CurrentCard > EndCard ->
    FreqTree;
form_one_group_recursive(CurrentCard, EndCard, FreqTree) ->
    case gb_trees:lookup(CurrentCard, FreqTree) of
        none ->
            false;
        {value, Count} ->
            NewCount = Count - 1,
            UpdatedFreqTree = 
                if NewCount == 0 ->
                    gb_trees:delete(CurrentCard, FreqTree);
                true ->
                    gb_trees:update(CurrentCard, NewCount, FreqTree)
                end,
            form_one_group_recursive(CurrentCard + 1, EndCard, UpdatedFreqTree)
    end.