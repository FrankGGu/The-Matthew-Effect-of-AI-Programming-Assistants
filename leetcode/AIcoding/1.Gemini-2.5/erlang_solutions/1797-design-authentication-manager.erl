-module(auth_manager).
-export([new/1, generate/3, renew/3, count_unexpired_tokens/2]).

-record(auth_manager, {
    ttl,
    tokens
}).

new(TimeToLive) ->
    #auth_manager{ttl = TimeToLive, tokens = #{}}.

generate(Manager, TokenId, CurrentTime) ->
    #auth_manager{ttl = TTL, tokens = Tokens} = Manager,
    ExpirationTime = CurrentTime + TTL,
    NewTokens = maps:put(TokenId, ExpirationTime, Tokens),
    Manager#auth_manager{tokens = NewTokens}.

renew(Manager, TokenId, CurrentTime) ->
    #auth_manager{ttl = TTL, tokens = Tokens} = Manager,
    case maps:find(TokenId, Tokens) of
        {ok, ExpirationTime} when ExpirationTime > CurrentTime ->
            NewExpirationTime = CurrentTime + TTL,
            NewTokens = maps:put(TokenId, NewExpirationTime, Tokens),
            Manager#auth_manager{tokens = NewTokens};
        _ ->
            Manager
    end.

count_unexpired_tokens(Manager, CurrentTime) ->
    #auth_manager{tokens = Tokens} = Manager,
    lists:foldl(fun({_TokenId, ExpirationTime}, Acc) ->
                    if ExpirationTime > CurrentTime -> Acc + 1;
                       true -> Acc
                    end
                end, 0, maps:to_list(Tokens)).