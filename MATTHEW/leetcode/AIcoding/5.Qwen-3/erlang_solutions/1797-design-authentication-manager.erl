-module(authentication_manager).
-export([new/1, get_time_to_live/2, generate/3, renew/3, count_unexpired_tokens/1]).

new(MaxTime) ->
    {max_time, MaxTime, #{}};

get_time_to_live(AuthManager, Token) ->
    {_, _, Tokens} = AuthManager,
    case maps:find(Token, Tokens) of
        {ok, ExpireTime} ->
            ExpireTime - erlang:system_time(second);
        error ->
            -1
    end;

generate(AuthManager, Token, Time) ->
    {MaxTime, _, Tokens} = AuthManager,
    NewTokens = maps:put(Token, Time + MaxTime, Tokens),
    {MaxTime, _, NewTokens};

renew(AuthManager, Token, Time) ->
    {MaxTime, _, Tokens} = AuthManager,
    case maps:find(Token, Tokens) of
        {ok, ExpireTime} when ExpireTime > Time ->
            NewTokens = maps:put(Token, Time + MaxTime, Tokens),
            {MaxTime, _, NewTokens};
        _ ->
            AuthManager
    end;

count_unexpired_tokens(AuthManager) ->
    {_, _, Tokens} = AuthManager,
    Now = erlang:system_time(second),
    lists:foldl(fun({_Token, ExpireTime}, Acc) ->
                    if ExpireTime > Now -> Acc + 1;
                       true -> Acc
                    end
                end, 0, maps:to_list(Tokens)).