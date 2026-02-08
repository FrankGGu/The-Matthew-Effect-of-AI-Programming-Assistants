-module(solution).
-export([theNumberofTheSmallestUnoccupiedChair/2]).

theNumberofTheSmallestUnoccupiedChair(Times, TargetPerson) ->
    Events = create_events(Times),
    SortedEvents = lists:sort(fun({T1, Type1, _}, {T2, Type2, _}) ->
                                      if T1 =:= T2 -> Type1 < Type2; % Departures (Type 0) before Arrivals (Type 1)
                                         true -> T1 < T2
                                      end
                              end, Events),

    % Initial state:
    % AvailableChairs: A gb_trees storing available chair numbers (keys and values are chair numbers).
    % PersonToChair: A map storing PersonIdx -> ChairNumber for currently seated people.
    % MaxChairNumberAssigned: The highest chair number ever assigned.
    process_events(SortedEvents, TargetPerson, gb_trees:empty(), maps:new(), -1).

create_events(Times) ->
    create_events(Times, 0, []).

create_events([], _PersonIdx, Acc) ->
    Acc;
create_events([[ArrivalTime, DepartureTime] | Rest], PersonIdx, Acc) ->
    ArrivalEvent = {ArrivalTime, 1, PersonIdx},
    DepartureEvent = {DepartureTime, 0, PersonIdx},
    create_events(Rest, PersonIdx + 1, [DepartureEvent, ArrivalEvent | Acc]).

process_events([{_Time, Type, PersonIdx} | Rest], TargetPerson, AvailableChairs, PersonToChair, MaxChairNumberAssigned) ->
    case Type of
        0 -> % Departure event
            Chair = maps:get(PersonIdx, PersonToChair),
            NewPersonToChair = maps:remove(PersonIdx, PersonToChair),
            NewAvailableChairs = gb_trees:insert(Chair, Chair, AvailableChairs), % Add chair back to available
            process_events(Rest, TargetPerson, NewAvailableChairs, NewPersonToChair, MaxChairNumberAssigned);
        1 -> % Arrival event
            Chair = 
                case gb_trees:is_empty(AvailableChairs) of
                    true ->
                        % No chairs available, assign the next highest chair number
                        MaxChairNumberAssigned + 1;
                    false ->
                        % Smallest available chair
                        {SmallestChair, _} = gb_trees:smallest(AvailableChairs),
                        SmallestChair
                end,

            NewAvailableChairs = 
                case gb_trees:is_empty(AvailableChairs) of
                    true -> AvailableChairs; % No chairs were available, so no change to the set of available chairs
                    false -> gb_trees:delete_any(AvailableChairs) % Remove the smallest chair
                end,

            NewPersonToChair = maps:put(PersonIdx, Chair, PersonToChair),

            NewMaxChairNumberAssigned = 
                case gb_trees:is_empty(AvailableChairs) of % Check if AvailableChairs was empty *before* this arrival
                    true -> Chair; % If it was empty, we assigned a new highest chair number
                    false -> MaxChairNumberAssigned % Otherwise, we reused an existing chair, max remains same
                end,

            if PersonIdx =:= TargetPerson ->
                   Chair; % Found the target person's chair, return it
               true ->
                   process_events(Rest, TargetPerson, NewAvailableChairs, NewPersonToChair, NewMaxChairNumberAssigned)
            end
    end;
process_events([], _TargetPerson, _AvailableChairs, _PersonToChair, _MaxChairNumberAssigned) ->
    % This case should not be reached if targetPerson is guaranteed to arrive.
    % It's a safeguard for unhandled scenarios.
    error(target_person_not_found).