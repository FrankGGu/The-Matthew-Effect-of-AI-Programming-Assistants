-module(sequential_digits).
-export([sequential_digits/2]).

sequential_digits(Low, High) ->
    AllSequential = lists:foldl(fun(StartDigit, Acc) ->
                                    generate_from_start(StartDigit, Low, High, Acc)
                                end, [], lists:seq(1, 9)),
    lists:sort(AllSequential).

generate_from_start(CurrentNum, Low, High, Acc) ->
    if CurrentNum > High ->
        Acc;
       true ->
        NewAcc = if CurrentNum >= Low ->
                     [CurrentNum | Acc];
                    true ->
                     Acc
                 end,
        LastDigit = CurrentNum rem 10,
        if LastDigit == 9 ->
            NewAcc;
           true ->
            NextDigit = LastDigit + 1,
            NextNum = CurrentNum * 10 + NextDigit,
            generate_from_start(NextNum, Low, High, NewAcc)
        end
    end.