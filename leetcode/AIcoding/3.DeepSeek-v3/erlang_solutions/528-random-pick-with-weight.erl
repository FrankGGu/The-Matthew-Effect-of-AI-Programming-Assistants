-module(solution).
-export([init/1, pick_index/0]).

init(Weights) ->
    Sum = lists:sum(Weights),
    PrefixSums = lists:foldl(fun(W, Acc) -> 
        case Acc of
            [] -> [W];
            _ -> [hd(Acc) + W | Acc]
        end
    end, [], Weights),
    State = {lists:reverse(PrefixSums), Sum},
    put(state, State),
    ok.

pick_index() ->
    {PrefixSums, Sum} = get(state),
    Random = rand:uniform(Sum),
    binary_search(PrefixSums, Random).

binary_search(PrefixSums, Target) ->
    binary_search(PrefixSums, Target, 0, length(PrefixSums) - 1).

binary_search(PrefixSums, Target, Left, Right) ->
    if
        Left >= Right ->
            Left;
        true ->
            Mid = Left + (Right - Left) div 2,
            case lists:nth(Mid + 1, PrefixSums) of
                Val when Val < Target ->
                    binary_search(PrefixSums, Target, Mid + 1, Right);
                _ ->
                    binary_search(PrefixSums, Target, Left, Mid)
            end
    end.