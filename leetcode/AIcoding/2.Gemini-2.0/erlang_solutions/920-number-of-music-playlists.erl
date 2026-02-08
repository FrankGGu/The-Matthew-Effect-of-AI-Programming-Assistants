-module(number_of_music_playlists).
-export([num_music_playlists/3]).

num_music_playlists(N, Goal, K) ->
  num_music_playlists(N, Goal, K, #{}).

num_music_playlists(0, 0, _K, Cache) ->
  {Cache, 1};
num_music_playlists(0, _Goal, _K, Cache) ->
  {Cache, 0};
num_music_playlists(_N, 0, _K, Cache) ->
  {Cache, 0};
num_music_playlists(N, Goal, K, Cache) ->
  case maps:get({N, Goal}, Cache, undefined) of
    undefined ->
      {Cache1, WithNew} = num_music_playlists(N - 1, Goal - 1, K, Cache);
      {Cache2, WithoutNew} = num_music_playlists(N, Goal - 1, K, Cache1);
      WithNewVal = (WithNew * N) rem 1000000007;
      WithoutNewVal = (WithoutNew * max(0, N - K)) rem 1000000007;
      Result = (WithNewVal + WithoutNewVal) rem 1000000007;
      NewCache = maps:put({N, Goal}, Result, Cache2);
      {NewCache, Result};
    Value ->
      {Cache, Value}
  end.