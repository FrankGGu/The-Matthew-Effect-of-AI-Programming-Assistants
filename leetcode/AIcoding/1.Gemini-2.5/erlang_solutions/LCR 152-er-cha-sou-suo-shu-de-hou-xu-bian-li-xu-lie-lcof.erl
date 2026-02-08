-module(solution).
-export([is_valid_postorder/1]).

is_valid_postorder([]) ->
    true;
is_valid_postorder([_]) ->
    true;
is_valid_postorder(Sequence) ->
    Root = lists:last(Sequence),
    SubSequence = lists:droplast(Sequence),

    LeftSubtree = lists:takewhile(fun(X) -> X < Root end, SubSequence),
    RightSubtree = lists:dropwhile(fun(X) -> X < Root end, SubSequence),

    RightSubtree_elements_valid = lists:all(fun(X) -> X > Root end, RightSubtree),

    LeftValid = is_valid_postorder(LeftSubtree),
    RightValid = is_valid_postorder(RightSubtree),

    RightSubtree_elements_valid and LeftValid and RightValid.