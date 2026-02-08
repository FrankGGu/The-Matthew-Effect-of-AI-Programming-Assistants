-module(solution).
-export([total_strength/1]).

total_strength(Strengths) ->
    N = length(Strengths),
    Mod = 1000000007,
    {MinStack, MaxStack} = build_min_max_stacks(Strengths),
    Sum = calculate_total(MinStack, MaxStack, Strengths, N, Mod),
    Sum rem Mod.

build_min_max_stacks(Strengths) ->
    MinStack = build_stack(Strengths, fun min/2),
    MaxStack = build_stack(Strengths, fun max/2),
    {MinStack, MaxStack}.

build_stack(Strengths, Fun) ->
    N = length(Strengths),
    Stack = lists:seq(0, N - 1),
    lists:foldl(fun(I, Acc) ->
        case Acc of
            [] -> [I];
            [H | T] ->
                if Fun(Strengths, I) < Fun(Strengths, H) ->
                    [I | Acc];
                true ->
                    [H | T]
                end
        end
    end, [], lists:seq(0, N - 1)).

calculate_total(_, _, _, 0, _) -> 0;
calculate_total(MinStack, MaxStack, Strengths, N, Mod) ->
    Total = 0,
    lists:foldl(fun(I, Acc) ->
        LeftMin = get_left_bound(MinStack, I),
        RightMin = get_right_bound(MinStack, I),
        LeftMax = get_left_bound(MaxStack, I),
        RightMax = get_right_bound(MaxStack, I),
        MinCount = (I - LeftMin) * (RightMin - I),
        MaxCount = (I - LeftMax) * (RightMax - I),
        Contribution = (lists:sum(lists:sublist(Strengths, I + 1, RightMin - I)) * MinCount * lists:sum(lists:sublist(Strengths, LeftMax + 1, I - LeftMax))) * MaxCount,
        (Acc + Contribution) rem Mod
    end, 0, lists:seq(0, N - 1)).

get_left_bound(Stack, Index) ->
    get_bound(Stack, Index, fun(A, B) -> A < B end).

get_right_bound(Stack, Index) ->
    get_bound(Stack, Index, fun(A, B) -> A > B end).

get_bound(Stack, Index, Fun) ->
    case lists:keyfind(Index, 1, Stack) of
        false -> -1;
        {Index, Prev} -> Prev
    end.