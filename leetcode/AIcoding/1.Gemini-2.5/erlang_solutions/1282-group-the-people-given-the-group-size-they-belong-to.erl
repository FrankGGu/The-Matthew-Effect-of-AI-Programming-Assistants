-module(solution).
-export([group_the_people/1]).

group_the_people(GroupSizes) ->
    % Create a list of {PersonIndex, GroupSize} tuples.
    % PersonIndex ranges from 0 to length(GroupSizes) - 1.
    IndexedPeople = lists:zip(lists:seq(0, length(GroupSizes) - 1), GroupSizes),

    % Call the accumulator function to process people and form groups.
    % GroupsInProgress: A map where keys are group sizes and values are {CurrentCount, [PersonIndex]} tuples.
    % FinalGroups: A list accumulating the completed groups.
    group_people_acc(IndexedPeople, #{}, []).

group_people_acc([], _GroupsInProgress, FinalGroups) ->
    % All people have been processed. Reverse the accumulated groups to maintain original order (optional, but common).
    lists:reverse(FinalGroups);
group_people_acc([{PersonIndex, Size} | Rest], GroupsInProgress, FinalGroups) ->
    % Retrieve the current count and list of people for this 'Size' from the map.
    % If no entry exists, default to {0, []}.
    {CurrentCount, CurrentPeopleList} = maps:get(Size, GroupsInProgress, {0, []}),

    % Add the current person to the list and increment the count.
    NewCount = CurrentCount + 1,
    NewPeopleList = [PersonIndex | CurrentPeopleList],

    % Check if the group is now full (i.e., NewCount equals the required Size).
    if
        NewCount == Size ->
            % The group is full.
            % Add the completed group to the FinalGroups list.
            NewFinalGroups = [NewPeopleList | FinalGroups],
            % Remove this group size entry from GroupsInProgress as it's completed.
            NewGroupsInProgress = maps:remove(Size, GroupsInProgress),
            % Continue processing the rest of the people.
            group_people_acc(Rest, NewGroupsInProgress, NewFinalGroups);
        true ->
            % The group is not yet full.
            % Update the GroupsInProgress map with the new count and list for this size.
            NewGroupsInProgress = maps:put(Size, {NewCount, NewPeopleList}, GroupsInProgress),
            % Continue processing the rest of the people.
            group_people_acc(Rest, NewGroupsInProgress, FinalGroups)
    end.