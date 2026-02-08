-module(first_bad_version).
-export([first_bad_version/1]).

isBadVersion(Version) ->
  % Replace with your actual isBadVersion implementation.
  % For LeetCode, this function is provided.
  % Example:
  Version >= 4.

first_bad_version(N) ->
  find_first_bad_version(1, N).

find_first_bad_version(Low, High) ->
  if Low =:= High ->
    Low;
  true ->
    Mid = Low + (High - Low) div 2,
    if isBadVersion(Mid) ->
      find_first_bad_version(Low, Mid);
    true ->
      find_first_bad_version(Mid + 1, High)
    end
  end.