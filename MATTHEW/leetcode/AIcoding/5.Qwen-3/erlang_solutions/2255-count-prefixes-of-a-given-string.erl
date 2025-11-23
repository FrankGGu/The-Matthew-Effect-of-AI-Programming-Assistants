-module(solution).
-export([prefix_count/2]).

prefix_count(S, P) ->
    prefix_count(S, P, 0).

prefix_count([], _, Count) ->
    Count;
prefix_count(_, [], Count) ->
    Count;
prefix_count([H|T], [H|P], Count) ->
    prefix_count(T, P, Count + 1);
prefix_count([_|T], P, Count) ->
    prefix_count(T, P, Count).