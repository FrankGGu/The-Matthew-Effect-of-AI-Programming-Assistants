-module(three_sum).
-export([three_sum/1]).

three_sum(Nums) ->
    Sorted = lists:sort(Nums),
    three_sum(Sorted, [], []).

three_sum([], _, Result) ->
    Result;
three_sum([A | Rest], Acc, Result) ->
    case A of
        _ when A > 0 -> Result;
        _ ->
            case lists:keymember(A, 1, Acc) of
                true -> three_sum(Rest, Acc, Result);
                false ->
                    NewAcc = [{A, Rest} | Acc],
                    three_sum(Rest, NewAcc, Result)
            end
    end.

three_sum([], _, _) ->
    [];
three_sum([A | Rest], Acc, Result) ->
    B = find_two_sum(Rest, -A),
    case B of
        [] -> three_sum(Rest, Acc, Result);
        _ ->
            lists:foldl(fun({B1, B2}, AccList) ->
                            [lists:sort([A, B1, B2]) | AccList]
                        end, Result, B)
    end.

find_two_sum([], _) ->
    [];
find_two_sum([B | Rest], Target) ->
    C = Target - B,
    case lists:member(C, Rest) of
        true ->
            [ {B, C} | find_two_sum(Rest, Target) ];
        false ->
            find_two_sum(Rest, Target)
    end.