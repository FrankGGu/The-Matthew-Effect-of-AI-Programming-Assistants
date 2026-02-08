-module(solution).
-export([find_occurrences/3]).

find_occurrences(Arr, Element, Queries) ->
    OccurrencesList = find_all_indices(Arr, Element, 0, []),

    OccurrencesArray = array:from_list(OccurrencesList),
    OccurrencesSize = array:size(OccurrencesArray),

    lists:map(fun(Kth) ->
                  Index = Kth - 1,
                  case Index >= 0 andalso Index < OccurrencesSize of
                      true -> array:get(Index, OccurrencesArray);
                      false -> -1
                  end
              end, Queries).

find_all_indices(Arr, Element, CurrentIndex, Acc) ->
    case Arr of
        [] -> 
            lists:reverse(Acc);
        [H|T] ->
            case H =:= Element of
                true -> 
                    find_all_indices(T, Element, CurrentIndex + 1, [CurrentIndex | Acc]);
                false -> 
                    find_all_indices(T, Element, CurrentIndex + 1, Acc)
            end
    end.