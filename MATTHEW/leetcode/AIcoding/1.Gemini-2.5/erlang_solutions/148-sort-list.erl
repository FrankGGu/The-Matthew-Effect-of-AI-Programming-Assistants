-module(solution).
-export([sortList/1]).

sortList(nil) -> nil;
sortList({_, nil} = Head) -> Head; % Base case: empty or single node list is already sorted
sortList(Head) ->
    {FirstHalf, SecondHalf} = split(Head),
    SortedFirst = sortList(FirstHalf),
    SortedSecond = sortList(SecondHalf),
    merge(SortedFirst, SortedSecond).

-spec get_val({any(), any()}) -> any().
get_val({Val, _}) -> Val.

-spec get_next({any(), any()}) -> any().
get_next({_, Next}) -> Next.

-spec make_node(any(), any()) -> {any(), any()}.
make_node(Val, Next) -> {Val, Next}.

-spec split({any(), any()}) -> {{any(), any()}, {any(), any()}}.
split(Head) ->
    Slow = Head,
    Fast = Head,
    PrevOfSlow = nil, % Node before Slow
    {MiddleNode, NodeBeforeMiddle} = find_middle(Slow, Fast, PrevOfSlow),

    SecondHalfHead = get_next(MiddleNode),
    FirstHalfHead = copy_list_until_node(Head, MiddleNode),

    {FirstHalfHead, SecondHalfHead}.

-spec find_middle({any(), any()}, {any(), any()}, any()) -> {{any(), any()}, {any(), any()}}.
find_middle(Slow, Fast, PrevOfSlow) ->
    case get_next(Fast) of
        nil -> {Slow, PrevOfSlow}; % Fast reached end, Slow is middle
        {_, _} = FastNext ->
            case get_next(FastNext) of
                nil -> {Slow, PrevOfSlow}; % FastNext reached end, Slow is before middle
                {_, _} = FastNextNext ->
                    find_middle(get_next(Slow), FastNextNext, Slow)
            end
    end.

-spec copy_list_until_node({any(), any()}, {any(), any()}) -> {any(), any()}.
copy_list_until_node(Current, TargetNode) ->
    case Current == TargetNode of
        true -> make_node(get_val(Current), nil);
        false -> make_node(get_val(Current), copy_list_until_node(get_next(Current), TargetNode))
    end.

-spec merge(any(), any()) -> any().
merge(nil, L2) -> L2;
merge(L1, nil) -> L1;
merge({V1, N1} = L1, {V2, N2} = L2) ->
    if
        V1 =< V2 -> make_node(V1, merge(N1, L2));
        true -> make_node(V2, merge(L1, N2))
    end.