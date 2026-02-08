-module(random_pick_with_blacklist).
-export([new/1, pick/1]).

-record(state, {
    size,
    mapping
}).

new(N, Blacklist) ->
    Size = N - length(Blacklist),
    State = #state{size = Size, mapping = #{}},
    create_mapping(N, Blacklist, State).

create_mapping(N, [], State) ->
    State;
create_mapping(N, [B | Rest], State) ->
    case B < State#state.size of
        true ->
            {NewState, _} = create_mapping_helper(N - 1, State, B, N - 1);
            create_mapping(N, Rest, NewState);
        false ->
            create_mapping(N, Rest, State)
    end.

create_mapping_helper(Start, State, Black, Curr) when Start > State#state.size - 1 ->
    {State, Black};
create_mapping_helper(Start, State, Black, Curr) ->
    case maps:is_key(Curr, State#state.mapping) of
        true ->
            create_mapping_helper(Start, State, Black, Curr - 1);
        false ->
            case lists:member(Curr, []) of
                true ->
                   create_mapping_helper(Start, State, Black, Curr - 1);
                false ->
                    {NewState, _} = State#state{mapping = maps:put(Black, Curr, State#state.mapping)},
                    {NewState, Black}
            end
    end.

pick(State) ->
    Rand = rand:uniform(State#state.size) - 1,
    case maps:is_key(Rand, State#state.mapping) of
        true ->
            maps:get(Rand, State#state.mapping);
        false ->
            Rand
    end.