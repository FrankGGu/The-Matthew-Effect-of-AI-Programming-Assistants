-module(solution).
-export([fill_missing_data/1]).

fill_missing_data(Data) ->
    lists:map(fun(#{value := V, time := T}) -> 
        case V of 
            undefined -> 
                {T, get_previous_value(T, Data)}
            _ -> 
                {T, V}
        end
    end, Data).

get_previous_value(_, []) -> undefined;
get_previous_value(T, [#{time := PrevT, value := V} | Rest]) when PrevT < T -> 
    case V of 
        undefined -> get_previous_value(T, Rest);
        _ -> V
    end;
get_previous_value(_, _) -> undefined.