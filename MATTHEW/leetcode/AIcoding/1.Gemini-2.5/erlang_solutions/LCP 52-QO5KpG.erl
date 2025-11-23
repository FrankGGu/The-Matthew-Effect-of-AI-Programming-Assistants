-module(solution).
-export([init/0, color/3, get_colored_count/1]).

-define(MIN_VAL, 1).
-define(MAX_VAL, 1000000000).

init() ->
    new(?MIN_VAL, ?MAX_VAL).

new(Low, High) ->
    {Low, High, 0, 0, nil, nil}.

push_down({Low, High, Count, Lazy, Left, Right}) when Lazy =/= 0 ->
    Mid = Low + (High - Low) div 2,
    NewLeft = case Left of
                  nil -> new(Low, Mid);
                  _ -> Left
              end,
    NewRight = case Right of
                   nil -> new(Mid + 1, High);
                   _ -> Right
               end,
    AppliedLeft = apply_lazy(NewLeft, Lazy),
    AppliedRight = apply_lazy(NewRight, Lazy),
    {Low, High, Count, 0, AppliedLeft, AppliedRight};
push_down(Tree) ->
    Tree.

apply_lazy({Low, High, _Count, _ChildLazy, Left, Right}, LazyTag) ->
    NewCount = case LazyTag of
                   1 -> High - Low + 1;
                   -1 -> 0
               end,
    NewChildLazy = LazyTag,
    {Low, High, NewCount, NewChildLazy, Left, Right}.

color(Tree, QLow, QHigh) ->
    update(Tree, QLow, QHigh, 1).

update({Low, High, Count, Lazy, Left, Right}, QLow, QHigh, Color) ->
    if QHigh < Low; QLow > High ->
            {Low, High, Count, Lazy, Left, Right};
       QLow =< Low andalso High =< QHigh ->
            apply_lazy({Low, High, Count, Lazy, Left, Right}, Color);
       true ->
            Mid = Low + (High - Low) div 2,
            {PushedLow, PushedHigh, PushedCount, 0, PushedLeft, PushedRight} = push_down({Low, High, Count, Lazy, Left, Right}),

            UpdatedLeft = update(PushedLeft, QLow, QHigh, Color),
            UpdatedRight = update(PushedRight, QLow, QHigh, Color),

            NewCount = element(3, UpdatedLeft) + element(3, UpdatedRight),
            {PushedLow, PushedHigh, NewCount, 0, UpdatedLeft, UpdatedRight}
    end.

get_colored_count(Tree) ->
    query(Tree, ?MIN_VAL, ?MAX_VAL).

query({Low, High, Count, Lazy, Left, Right}, QLow, QHigh) ->
    if QHigh < Low; QLow > High ->
            0;
       QLow =< Low andalso High =< QHigh ->
            Count;
       true ->
            Mid = Low + (High - Low) div 2,
            {PushedLow, PushedHigh, PushedCount, 0, PushedLeft, PushedRight} = push_down({Low, High, Count, Lazy, Left, Right}),

            query(PushedLeft, QLow, QHigh) + query(PushedRight, QLow, QHigh)
    end.