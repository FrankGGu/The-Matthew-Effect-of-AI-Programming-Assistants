-module(my_calendar).
-behaviour(gen_server).

-export([start_link/0, book/3]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

book(Pid, Start, End) ->
    gen_server:call(Pid, {book, Start, End}).

init([]) ->
    {ok, []}.

handle_call({book, NewStart, NewEnd}, _From, Calendar) ->
    case check_overlap(Calendar, NewStart, NewEnd) of
        true ->
            {reply, false, Calendar};
        false ->
            NewCalendar = [{NewStart, NewEnd} | Calendar],
            {reply, true, NewCalendar}
    end;
handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

check_overlap([], _NewStart, _NewEnd) ->
    false;
check_overlap([{S, E} | Rest], NewStart, NewEnd) ->
    if
        NewStart < E and NewEnd > S ->
            true;
        true ->
            check_overlap(Rest, NewStart, NewEnd)
    end.