-module(solution).
-export([eaten_apples/2]).

eaten_apples(Apples, Days) ->
    PriorityQueue = [],
    N = length(Apples),
    {Ans, _, _} = lists:foldl(fun(I, {Count, Q, Day}) ->
        case I =< N of
            true ->
                A = lists:nth(I, Apples),
                D = lists:nth(I, Days),
                NewQ = case A > 0 of
                    true -> insert({Day + D - 1, A}, Q);
                    false -> Q
                end;
            false ->
                NewQ = Q
        end,
        {NewCount, NewQ1} = eat_apple(NewQ, Day),
        {Count + NewCount, NewQ1, Day + 1}
    end, {0, PriorityQueue, 1}, lists:seq(1, N + 20000)),
    Ans.

eat_apple(Q, Day) ->
    case Q of
        [] -> {0, Q};
        _ ->
            {{Expire, Count}, Q1} = get_min(Q),
            case Expire >= Day of
                true ->
                    case Count - 1 of
                        0 -> {1, Q1};
                        NewCount -> {1, insert({Expire, NewCount}, Q1)}
                    end;
                false -> eat_apple(Q1, Day)
            end
    end.

insert({Expire, Count}, []) -> [{Expire, Count}];
insert({Expire, Count}, [H = {E, C} | T]) ->
    if
        Expire < E -> [{Expire, Count}, H | T];
        true -> [H | insert({Expire, Count}, T)]
    end.

get_min([H | T]) -> {H, T}.