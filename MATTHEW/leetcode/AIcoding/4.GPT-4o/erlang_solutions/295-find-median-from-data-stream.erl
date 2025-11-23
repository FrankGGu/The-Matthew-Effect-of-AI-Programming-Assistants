%% MedianFinder Module
%% - Initializes, adds numbers, and calculates the median.

-module(median_finder).
-export([init/0, add_num/1, find_median/0]).

-record(state, {nums = []}).

%% Initialize the median finder
init() -> 
    #state{}.

%% Add number to the stream
add_num(Num) ->
    State = get_state(),
    NewState = #state{nums = lists:append(State#state.nums, [Num])},
    set_state(NewState).

%% Find the median of the current numbers
find_median() ->
    State = get_state(),
    Nums = lists:sort(State#state.nums),
    Count = length(Nums),
    case Count rem 2 of
        0 -> 
            Middle1 = lists:nth(Count div 2, Nums),
            Middle2 = lists:nth(Count div 2 + 1, Nums),
            (Middle1 + Middle2) / 2.0;
        1 -> 
            lists:nth((Count div 2) + 1, Nums)
    end.

%% Helper functions to manage state
get_state() ->
    case process:get() of
        undefined -> #state{};
        State -> State
    end.

set_state(State) ->
    process:put(State).
