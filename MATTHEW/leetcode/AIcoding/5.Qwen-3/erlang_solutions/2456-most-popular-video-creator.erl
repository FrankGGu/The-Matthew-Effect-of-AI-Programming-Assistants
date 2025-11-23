-module(most_popular_video_creator).
-export([mostPopularVideos/2]).

mostPopularVideos(Records, 1) ->
    lists:usort([Title || {_, Title, _} <- Records]);
mostPopularVideos(Records, K) ->
    Map = maps:from_list([{Title, Count} || {_, Title, Count} <- Records]),
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A > B end, maps:to_list(Map)),
    [Title || {Title, _} <- lists:sublist(Sorted, K)].

mostPopularVideos(Records, K) ->
    mostPopularVideos(Records, K).