-module(alternating_groups_i).
-export([number_of_ways/1]).

number_of_ways(S) ->
    number_of_ways(S, 0, 0, 0).

number_of_ways([], _, _, Count) ->
    Count;
number_of_ways([H|T], Last, Len, Count) ->
    case H of
        $0 ->
            case Last of
                0 ->
                    number_of_ways(T, 0, Len + 1, Count);
                1 ->
                    number_of_ways(T, 0, 1, Count + Len);
                _ ->
                    number_of_ways(T, 0, 1, Count)
            end;
        $1 ->
            case Last of
                1 ->
                    number_of_ways(T, 1, Len + 1, Count);
                0 ->
                    number_of_ways(T, 1, 1, Count + Len);
                _ ->
                    number_of_ways(T, 1, 1, Count)
            end
    end.