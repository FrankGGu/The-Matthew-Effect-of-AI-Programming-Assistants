-module(solution).
-export([total_fruit/1]).

total_fruit(Fruits) ->
    TotalFruits = length(Fruits),
    max_fruits(Fruits, TotalFruits, 0, 0, 0, 0, 0).

max_fruits(_, TotalFruits, _, _, _, MaxFruits, MaxCount) when MaxCount >= TotalFruits -> 
    MaxFruits;
max_fruits(Fruits, TotalFruits, Start, End, Count, MaxFruits, MaxCount) when Start =< End ->
    case Count of
        0 -> 
            MaxFruits1 = max(MaxFruits, End - Start + 1),
            max_fruits(Fruits, TotalFruits, Start, End + 1, Count + 1, MaxFruits1, MaxCount);
        _ ->
            MaxFruits1 = max(MaxFruits, End - Start + 1),
            case maps:find(Fruits[End], Count) of
                {ok, Val} -> 
                    max_fruits(Fruits, TotalFruits, Start, End + 1, Count, MaxFruits1, MaxCount);
                error -> 
                    NewCount = maps:put(Fruits[End], 1, Count),
                    max_fruits(Fruits, TotalFruits, Start, End + 1, NewCount, MaxFruits1, MaxCount)
            end
    end.