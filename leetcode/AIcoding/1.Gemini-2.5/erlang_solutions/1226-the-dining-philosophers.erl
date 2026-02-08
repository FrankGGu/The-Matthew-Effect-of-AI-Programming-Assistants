-module(dining_philosophers).
-behaviour(gen_server).

-export([eats/6]).
-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-define(SERVER, ?MODULE).

-record(state, {
    forks :: array:array(atom()), % available | taken
    queue :: [{integer(), {pid(), reference()}}] % {PhilosopherId, From}
}).

start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

init([]) ->
    Forks = array:new(5, {default, available}),
    Queue = [],
    {ok, #state{forks = Forks, queue = Queue}}.

eats(PhilosopherId, PickLeftFork, PickRightFork, Eat, PutLeftFork, PutRightFork) ->
    ok = gen_server:call(?SERVER, {request_to_eat, PhilosopherId}),
    PickLeftFork(),
    PickRightFork(),
    Eat(),
    PutLeftFork(),
    PutRightFork(),
    gen_server:cast(?SERVER, {done_eating, PhilosopherId}).

handle_call({request_to_eat, PId}, From, State = #state{forks = Forks, queue = Queue}) ->
    LeftFork = PId,
    RightFork = (PId + 1) rem 5,
    case {array:get(LeftFork, Forks), array:get(RightFork, Forks)} of
        {available, available} ->
            NewForks1 = array:set(LeftFork, taken, Forks),
            NewForks2 = array:set(RightFork, taken, NewForks1),
            {reply, ok, State#state{forks = NewForks2}};
        _ ->
            NewQueue = Queue ++ [{PId, From}],
            {noreply, State#state{queue = NewQueue}}
    end.

handle_cast({done_eating, PId}, State = #state{forks = Forks, queue = Queue}) ->
    LeftFork = PId,
    RightFork = (PId + 1) rem 5,
    NewForks1 = array:set(LeftFork, available, Forks),
    NewForks2 = array:set(RightFork, available, NewForks1),
    {FinalForks, RemainingQueue} = fulfill_pending(NewForks2, Queue),
    {noreply, State#state{forks = FinalForks, queue = RemainingQueue}}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

fulfill_pending(ForksState, Requests) ->
    {FinalForksState, RemainingRequestsRev} = lists:foldl(
        fun({PId, From}, {AccForksState, AccRemainingRequests}) ->
            LeftFork = PId,
            RightFork = (PId + 1) rem 5,
            case {array:get(LeftFork, AccForksState), array:get(RightFork, AccForksState)} of
                {available, available} ->
                    NewAccForksState1 = array:set(LeftFork, taken, AccForksState),
                    NewAccForksState2 = array:set(RightFork, taken, NewAccForksState1),
                    gen_server:reply(From, ok),
                    {NewAccForksState2, AccRemainingRequests};
                _ ->
                    {AccForksState, [{PId, From} | AccRemainingRequests]}
            end
        end,
        {ForksState, []},
        Requests
    ),
    {FinalForksState, lists:reverse(RemainingRequestsRev)}.