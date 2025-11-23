-record(state, {n = 0 :: integer(), 
                uploaded = sets:new() :: sets:set(integer()),
                longest = 0 :: integer()}).

init(N) ->
    #state{n = N}.

upload(Video, State) ->
    Uploaded = sets:add_element(Video, State#state.uploaded),
    NewLongest = case State#state.longest + 1 of
        Next when Next =< State#state.n ->
            case sets:is_element(Next, Uploaded) of
                true -> find_longest(Next, Uploaded, State#state.n);
                false -> State#state.longest
            end;
        _ -> State#state.longest
    end,
    State#state{uploaded = Uploaded, longest = NewLongest}.

find_longest(Current, Uploaded, N) ->
    case Current + 1 =< N andalso sets:is_element(Current + 1, Uploaded) of
        true -> find_longest(Current + 1, Uploaded, N);
        false -> Current
    end.

longest(State) ->
    State#state.longest.