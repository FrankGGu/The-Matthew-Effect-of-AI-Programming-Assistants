-module(solution).
-export([can_form_array/2]).

can_form_array(P, A) ->
    lists:all(fun(X) -> lists:member(X, A) end, P) andalso
    lists:all(fun(X) -> lists:member(X, A) end, lists:sublist(P, 1, length(A))).