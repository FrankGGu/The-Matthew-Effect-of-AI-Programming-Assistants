-module(solution).
-export([findAllPeople/3]).

init_dsu(People) ->
    lists:foldl(fun(P, {ParentAcc, RankAcc}) ->
                        {maps:put(P, P, ParentAcc), maps:put(P, 0, RankAcc)}
                end, {maps:new(), maps:new()}, People).

find(P, ParentMap) ->
    case maps:get(P, ParentMap) of
        P -> {P, ParentMap}; %% P is its own parent, so it's a root
        Parent ->
            {Root, NewParentMap} = find(Parent, ParentMap),
            {Root, maps:put(P, Root, NewParentMap)}
    end.

union(P1, P2, ParentMap0, RankMap0) ->
    {Root1, ParentMap1} = find(P1, ParentMap0),
    {Root2, ParentMap2} = find(P2, ParentMap1),
    ParentMap = ParentMap2, %% ParentMap after path compression for both P1 and P2

    if Root1 =:= Root2 ->
            {ParentMap, RankMap0}; %% Already in the same set
        true ->
            Rank1 = maps:get(Root1, RankMap0),
            Rank2 = maps:get(Root2, RankMap0),
            if Rank1 < Rank2 ->
                    {maps:put(Root1, Root2, ParentMap), RankMap0};
                Rank1 > Rank2 ->
                    {maps:put(Root2, Root1, ParentMap), RankMap0};
                true -> %% Ranks are equal, make one root child of the other and increment rank
                    {maps:put(Root2, Root1, ParentMap), maps:put(Root1, Rank1 + 1, RankMap0)}
            end
    end.

findAllPeople(_N, Meetings, FirstPerson) ->
    %% 1. Initialize the set of people who know the secret.
    %% Person 0 always knows the secret, and FirstPerson also knows it initially.
    SecretKnowers0 = gb_sets:from_list([0, FirstPerson]),

    %% 2. Group meetings by their time.
    %% This allows processing all meetings that occur at the same time together.
    MeetingsByTime = lists:foldl(
        fun({P1, P2, Time}, Acc) ->
            maps:update_with(Time, fun(List) -> [{P1, P2}|List] end, [{P1, P2}], Acc)
        end,
        maps:new(),
        Meetings
    ),

    %% 3. Get a sorted list of all unique meeting times.
    SortedTimes = lists:sort(maps:keys(MeetingsByTime)),

    %% 4. Process meetings time by time.
    %% For each time slice, we determine who learns the secret.
    FinalSecretKnowers = lists:foldl(
        fun(Time, CurrentSecretKnowers) ->
            MeetingsAtTime = maps:get(Time, MeetingsByTime),

            %% Identify all unique people involved in meetings at the current time.
            PeopleInCurrentMeetings = gb_sets:to_list(
                lists:foldl(fun({P1, P2}, Acc) -> gb_sets:add(P1, gb_sets:add(P2, Acc)) end, gb_sets:new(), MeetingsAtTime)
            ),

            %% Initialize a DSU structure for only the people involved in meetings at this time.
            %% This ensures that connections from previous times do not persist.
            {ParentMap0, RankMap0} = init_dsu(PeopleInCurrentMeetings),

            %% Perform union operations for all meetings happening at this time.
            {ParentMap1, RankMap1} = lists:foldl(
                fun({P1, P2}, {PM, RM}) -> union(P1, P2, PM, RM) end,
                {ParentMap0, RankMap0},
                MeetingsAtTime
            ),

            %% Identify which connected components (roots) in the DSU contain at least one person
            %% who already knows the secret from previous times or initial conditions.
            SecretKnowingRoots = gb_sets:new(),
            {ParentMap2, _RankMap2} = lists:foldl(
                fun(Person, {PM, SKR}) ->
                    {Root, NewPM} = find(Person, PM),
                    if gb_sets:is_element(Person, CurrentSecretKnowers) ->
                        {NewPM, gb_sets:add(Root, SKR)};
                    true ->
                        {NewPM, SKR}
                    end
                end,
                {ParentMap1, SecretKnowingRoots},
                PeopleInCurrentMeetings
            ),
            ParentMap = ParentMap2, %% Final ParentMap after finding roots for all people

            %% Update the set of secret knowers:
            %% Any person in a component whose root is in SecretKnowingRoots now knows the secret.
            lists:foldl(
                fun(Person, AccSecretKnowers) ->
                    {Root, _} = find(Person, ParentMap),
                    if gb_sets:is_element(Root, SecretKnowingRoots) ->
                        gb_sets:add(Person, AccSecretKnowers);
                    true ->
                        AccSecretKnowers
                    end
                end,
                CurrentSecretKnowers,
                PeopleInCurrentMeetings
            )
        end,
        SecretKnowers0,
        SortedTimes
    ),

    %% Convert the final set of secret knowers to a list.
    gb_sets:to_list(FinalSecretKnowers).