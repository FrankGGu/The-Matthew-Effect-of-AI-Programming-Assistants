-module(solution).
-export([countTexts/1]).

countTexts(PressedKeys) ->
    N = length(PressedKeys),
    count_texts(PressedKeys, N, 0, 1).

count_texts(_, 0, Acc, _) -> 
    Acc rem 1000000007;
count_texts(PressedKeys, N, Acc, Consecutive) ->
    Key = list_to_integer(binary_to_list(PressedKeys)),
    Count = case Key of
        2 -> min(Consecutive, 1);
        3 -> min(Consecutive, 1);
        4 -> min(Consecutive, 1);
        5 -> min(Consecutive, 1);
        6 -> min(Consecutive, 1);
        7 -> min(Consecutive, 4);
        8 -> min(Consecutive, 1);
        9 -> min(Consecutive, 4);
        _ -> 0
    end,
    NewAcc = (Acc + Count) rem 1000000007,
    count_texts(PressedKeys, N - 1, NewAcc, if Key == list_to_integer(binary_to_list(PressedKeys)) -> Consecutive + 1; true -> 1 end).