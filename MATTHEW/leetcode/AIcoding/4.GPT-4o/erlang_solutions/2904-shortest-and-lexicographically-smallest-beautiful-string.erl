-module(solution).
-export([smallest_beautiful_string/2]).

smallest_beautiful_string(N, K) ->
    Result = string:to_list(<<"a">> ++ lists:duplicate(N-1, $z)),
    case find_beautiful_string(Result, K) of
        none -> <<"">>;
        {ok, String} -> list_to_binary(String)
    end.

find_beautiful_string(String, K) ->
    case next_beautiful_string(String, K) of
        none -> none;
        NewString -> ok, NewString
    end.

next_beautiful_string(String, K) ->
    NextString = next_permutation(String, K),
    if valid(NextString) -> {ok, NextString}; 
       true -> none 
    end.

next_permutation(String, K) ->
    Next = lists:reverse(String),
    case lists:foldl(fun(X, Acc) -> 
                       case Acc of 
                           {none, _} -> {none, []}; 
                           {ok, L} -> 
                               case next_char(X, L, K) of 
                                   none -> {none, []}; 
                                   NewChar -> {ok, [NewChar | L]} 
                               end 
                       end 
                   end, {ok, []}, Next) of
        {ok, L} -> lists:reverse(L);
        {none, _} -> none
    end.

next_char(Char, Acc, K) ->
    case (lists:member(Char, Acc) orelse Char > $z) of
        true -> none;
        false -> 
            case lists:foldl(fun(X, Acc) -> 
                               case Acc of 
                                   none -> none; 
                                   {ok, L} ->
                                       if X < K -> {ok, X}; true -> {ok, L} 
                                       end 
                               end 
                           end, {ok, []}, [Char + 1, Char + 2, Char + 3]) of
                {ok, L} -> hd(L);
                none -> none
            end
    end.

valid(String) ->
    lists:all(fun(X) -> lists:member(X, [$a, $b, $c]) end, String).