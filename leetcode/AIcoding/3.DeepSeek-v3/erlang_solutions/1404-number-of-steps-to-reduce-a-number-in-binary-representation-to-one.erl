-module(solution).
-export([num_steps/1]).

num_steps(S) ->
    Bin = list_to_binary(S),
    num_steps(binary_to_list(Bin), 0).

num_steps("1", Steps) ->
    Steps;
num_steps(BinStr, Steps) ->
    case lists:last(BinStr) of
        $0 ->
            NewBinStr = lists:droplast(BinStr),
            num_steps(NewBinStr, Steps + 1);
        $1 ->
            NewBinStr = add_one(BinStr),
            num_steps(NewBinStr, Steps + 1)
    end.

add_one(BinStr) ->
    add_one(lists:reverse(BinStr), [], 1).

add_one([], Acc, Carry) when Carry =:= 1 ->
    lists:reverse([$1 | Acc]);
add_one([], Acc, _) ->
    lists:reverse(Acc);
add_one([H | T], Acc, Carry) ->
    case H of
        $0 when Carry =:= 1 ->
            add_one(T, [$1 | Acc], 0);
        $1 when Carry =:= 1 ->
            add_one(T, [$0 | Acc], 1);
        _ ->
            add_one(T, [H | Acc], Carry)
    end.