-module(solution).
-export([intersection_size_at_least_two/1]).

intersection_size_at_least_two(Intervals) ->
    Sorted = lists:sort(fun({A1, B1}, {A2, B2}) -> 
        case A1 - A2 of 
            0 -> B1 - B2; 
            Other -> Other 
        end 
    end, Intervals),
    {_, Count} = lists:foldl(fun({A, B}, {Last, Count}) -> 
        case Last of 
            [] -> {lists:duplicate(2, B), Count + 2}; 
            [X, Y] -> 
                if 
                    A > Y -> {lists:duplicate(2, B), Count + 2}; 
                    A =< Y andalso B < Y -> {Last, Count}; 
                    true -> {Last, Count} 
                end 
        end 
    end, {[], 0}, Sorted),
    Count.