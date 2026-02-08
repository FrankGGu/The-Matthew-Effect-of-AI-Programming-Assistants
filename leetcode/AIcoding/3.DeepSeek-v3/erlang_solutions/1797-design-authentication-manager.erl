-module(auth_manager).
-export([init/1, generate/3, renew/3, count_unexpired_tokens/2]).

-record(token, {token_id, current_time, time_to_live}).

init(TimeToLive) ->
    spawn(fun() -> loop(#{}, TimeToLive) end).

loop(Tokens, TimeToLive) ->
    receive
        {From, generate, TokenId, CurrentTime} ->
            NewTokens = maps:put(TokenId, #token{token_id=TokenId, current_time=CurrentTime, time_to_live=TimeToLive}, Tokens),
            From ! ok,
            loop(NewTokens, TimeToLive);
        {From, renew, TokenId, CurrentTime} ->
            case maps:find(TokenId, Tokens) of
                {ok, #token{current_time=CT, time_to_live=TTL}} when CurrentTime < CT + TTL ->
                    NewTokens = maps:update(TokenId, #token{token_id=TokenId, current_time=CurrentTime, time_to_live=TTL}, Tokens),
                    From ! ok,
                    loop(NewTokens, TimeToLive);
                _ ->
                    From ! error,
                    loop(Tokens, TimeToLive)
            end;
        {From, count_unexpired_tokens, CurrentTime} ->
            Count = maps:fold(fun(_, #token{current_time=CT, time_to_live=TTL}, Acc) ->
                                case CurrentTime < CT + TTL of
                                    true -> Acc + 1;
                                    false -> Acc
                                end
                              end, 0, Tokens),
            From ! {ok, Count},
            loop(Tokens, TimeToLive)
    end.

generate(Pid, TokenId, CurrentTime) ->
    Pid ! {self(), generate, TokenId, CurrentTime},
    receive
        ok -> ok
    end.

renew(Pid, TokenId, CurrentTime) ->
    Pid ! {self(), renew, TokenId, CurrentTime},
    receive
        ok -> ok;
        error -> error
    end.

count_unexpired_tokens(Pid, CurrentTime) ->
    Pid ! {self(), count_unexpired_tokens, CurrentTime},
    receive
        {ok, Count} -> Count
    end.