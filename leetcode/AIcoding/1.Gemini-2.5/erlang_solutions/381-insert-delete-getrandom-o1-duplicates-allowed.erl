-module(randomized_collection).
-export([new/0, insert/2, remove/2, get_random/1]).

new() ->
    % Initialize the random seed for rand:uniform.
    rand:seed(erlang:now()),
    #{ elements => array:new(), indices => #{}, size => 0 }.

insert(Val, State) ->
    Elements = maps:get(elements, State),
    Indices = maps:get(indices, State),
    Size = maps:get(size, State),

    % Determine the return value: true if Val was not present before insertion.
    ReturnTrue = not maps:is_key(Val, Indices),

    % Add Val to the end of the elements array. The new index will be 'Size'.
    NewElements = array:set(Size, Val, Elements),

    % Update the indices map.
    % Get the existing set of indices for Val, or a new empty set if Val is not present.
    ValIndices = maps:get(Val, Indices, gb_sets:new()),
    % Add the new index (Size) to the set.
    NewValIndices = gb_sets:add(Size, ValIndices),
    % Update the map with the new set of indices for Val.
    NewIndices = maps:put(Val, NewValIndices, Indices),

    % Construct the new state.
    NewState = State#{ elements => NewElements, indices => NewIndices, size => Size + 1 },
    {ReturnTrue, NewState}.

remove(Val, State) ->
    Elements = maps:get(elements, State),
    Indices = maps:get(indices, State),
    Size = maps:get(size, State),

    case maps:find(Val, Indices) of
        error -> % Val is not in the collection.
            {false, State};
        {ok, ValIndices} ->
            % Get an arbitrary index 'Idx' where 'Val' is located.
            {Idx, _} = gb_sets:take_any(ValIndices),

            LastIdx = Size - 1,
            LastVal = array:get(LastIdx, Elements),

            % Swap the element at 'Idx' (which is 'Val') with the last element 'LastVal'.
            NewElements = array:set(Idx, LastVal, Elements),
            % The last element is now logically removed by decrementing 'Size'.

            % Update the indices map for 'Val'.
            NewValIndices = gb_sets:delete(Idx, ValIndices),
            NewIndices1 = maps:put(Val, NewValIndices, Indices),

            % If the set of indices for 'Val' becomes empty, remove 'Val' from the map.
            NewIndices2 = 
                if gb_sets:is_empty(NewValIndices) ->
                    maps:remove(Val, NewIndices1);
                else
                    NewIndices1
                end,

            % If 'Val' was not the last element, 'LastVal' moved to 'Idx'.
            % We need to update 'LastVal's indices: remove 'LastIdx' and add 'Idx'.
            NewIndices3 = 
                if Idx =/= LastIdx ->
                    LastValIndices = maps:get(LastVal, NewIndices2),
                    NewLastValIndices = gb_sets:delete(LastIdx, LastValIndices),
                    NewLastValIndices2 = gb_sets:add(Idx, NewLastValIndices),
                    maps:put(LastVal, NewLastValIndices2, NewIndices2);
                else % Idx == LastIdx, meaning Val was the last element. No need to update LastVal's indices.
                    NewIndices2
                end,

            % Construct the new state with decremented size.
            NewState = State#{ elements => NewElements, indices => NewIndices3, size => Size - 1 },
            {true, NewState}
    end.

get_random(State) ->
    Elements = maps:get(elements, State),
    Size = maps:get(size, State),

    % Generate a random index between 0 and Size-1.
    % rand:uniform(N) returns an integer from 1 to N.
    RandIdx = rand:uniform(Size) - 1,

    % Retrieve and return the element at the random index.
    array:get(RandIdx, Elements).