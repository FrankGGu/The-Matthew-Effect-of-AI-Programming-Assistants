-module(solution).
-export([search/2]).

search(_, []) ->
    [];
search(Value, [#{value := V, left := Left, right := Right} | _]) when V == Value ->
    [V];
search(Value, [#{value := V, left := Left, right := Right} | _]) when V < Value ->
    search(Value, Left);
search(Value, [#{value := V, left := Left, right := Right} | _]) ->
    search(Value, Right).