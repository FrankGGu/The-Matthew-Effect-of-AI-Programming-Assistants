-module(solution).
-export([garbage_collection/2]).

garbage_collection(Garbage, Travel) ->
    {TotalTime, LastIndex} = lists:foldl(fun (Type, {AccTime, Last}) ->
        Time = string:length(Type) + lists:nth(Last, Travel),
        {AccTime + Time, Last + 1}
    end, {0, 1}, Garbage),
    TotalTime + lists:sum(Travel).