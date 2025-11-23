-module(solution).
-export([equalize/2]).

equalize(A, B) ->
    equalize(A, B, 0).

equalize(A, B, Steps) when A == B ->
    Steps;
equalize(A, B, Steps) when A > B ->
    equalize(A - B, B, Steps + 1);
equalize(A, B, Steps) ->
    equalize(A, B - A, Steps + 1).