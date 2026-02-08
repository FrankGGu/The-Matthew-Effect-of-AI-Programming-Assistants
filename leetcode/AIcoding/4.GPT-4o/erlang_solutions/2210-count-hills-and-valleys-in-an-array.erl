-module(solution).
-export([count_hills_and_valleys/1]).

count_hills_and_valleys(Arr) ->
    count_hills_and_valleys(Arr, 0, 0).

count_hills_and_valleys([], Hills, Valleys) ->
    Hills + Valleys;
count_hills_and_valleys([_], Hills, Valleys) ->
    Hills + Valleys;
count_hills_and_valleys([A, B | Rest], Hills, Valleys) when A < B ->
    count_hills_and_valleys([{A, B} | Rest], Hills, Valleys + 1);
count_hills_and_valleys([A, B | Rest], Hills, Valleys) when A > B ->
    count_hills_and_valleys([{A, B} | Rest], Hills + 1, Valleys);
count_hills_and_valleys([_ | Rest], Hills, Valleys) ->
    count_hills_and_valleys(Rest, Hills, Valleys).