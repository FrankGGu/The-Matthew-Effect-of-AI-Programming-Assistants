-module(authentication_manager).
-export([start/1, generate/2, renew/2, countUnexpiredTokens/1]).

-record(state, {ttl, tokens = dict:new()}).

start(TTL) ->
    spawn(fun() -> loop(#state{ttl = TTL}) end).

generate(Pid, TokenId, CurrentTime) ->
    Pid ! {generate, TokenId, CurrentTime},
    ok.

renew(Pid, TokenId, CurrentTime) ->
    Pid ! {renew, TokenId, CurrentTime},
    ok.

countUnexpiredTokens(Pid, CurrentTime) ->
    Pid ! {count, CurrentTime, self()},
    receive
        {count_result, Count} ->
            Count
    end.

loop(State) ->
    receive
        {generate, TokenId, CurrentTime} ->
            NewTokens = dict:put(TokenId, CurrentTime + State#state.ttl, State#state.tokens),
            loop(State#state{tokens = NewTokens});
        {renew, TokenId, CurrentTime} ->
            case dict:is_key(TokenId, State#state.tokens) of
                true ->
                    NewTokens = dict:update(TokenId, fun(_) -> CurrentTime + State#state.ttl end, State#state.tokens),
                    loop(State#state{tokens = NewTokens});
                false ->
                    loop(State)
            end;
        {count, CurrentTime, Caller} ->
            Count = count_unexpired(State#state.tokens, CurrentTime),
            Caller ! {count_result, Count},
            loop(State)
    end.

count_unexpired(Tokens, CurrentTime) ->
    count_unexpired(dict:to_list(Tokens), CurrentTime, 0).

count_unexpired([], _CurrentTime, Count) ->
    Count;
count_unexpired([{_TokenId, Expiry} | Rest], CurrentTime, Count) ->
    case Expiry > CurrentTime of
        true ->
            count_unexpired(Rest, CurrentTime, Count + 1);
        false ->
            count_unexpired(Rest, CurrentTime, Count)
    end.