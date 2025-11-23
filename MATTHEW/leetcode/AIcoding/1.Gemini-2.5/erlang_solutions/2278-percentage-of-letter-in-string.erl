-module(solution).
-export([percentage_of_letter/2]).

percentage_of_letter(S, Letter) ->
    Count = lists:foldl(fun(Char, Acc) ->
                            if Char == Letter -> Acc + 1;
                               true -> Acc
                            end
                        end, 0, S),
    TotalLength = length(S),
    if TotalLength == 0 ->
        0;
       true ->
        (Count * 100) div TotalLength
    end.