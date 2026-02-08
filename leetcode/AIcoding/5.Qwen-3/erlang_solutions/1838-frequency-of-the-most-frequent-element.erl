-module(frequency_of_most_frequent_element).
-export([max_freq/1]).

max_freq(Nums) ->
    max_freq(Nums, 0, 0, 0, 0).

max_freq([], _, _, Max, _) ->
    Max;
max_freq([H | T], Left, Right, Max, CurrentSum) ->
    CurrentSum1 = CurrentSum + H,
    while_right(H, T, Left, Right, CurrentSum1, Max, H).

while_right(_, [], _, _, CurrentSum, Max, _) ->
    max_freq([], 0, 0, max(Max, (CurrentSum - 0) div 1), 0);
while_right(H, [N | NT], Left, Right, CurrentSum, Max, Target) ->
    if
        N > Target ->
            max_freq([N | NT], Left, Right, Max, CurrentSum);
        true ->
            NewRight = Right + 1,
            if
                (N - Target) * (NewRight - Left) > (CurrentSum - H) ->
                    max_freq([N | NT], Left + 1, NewRight, Max, CurrentSum - H);
                true ->
                    max_freq([N | NT], Left, NewRight, max(Max, (CurrentSum - H) div (NewRight - Left)), CurrentSum)
            end
    end.