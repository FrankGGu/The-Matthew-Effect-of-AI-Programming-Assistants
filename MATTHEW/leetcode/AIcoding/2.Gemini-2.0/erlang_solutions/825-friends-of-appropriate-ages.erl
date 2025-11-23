-module(friends_of_appropriate_ages).
-export([num_friend_requests/1]).

num_friend_requests(Ages) ->
  Counts = lists:foldl(
    fun(Age, Acc) ->
      maps:update_with(Age, fun(Count) -> Count + 1 end, 1, Acc)
    end,
    #{},
    Ages
  ),

  lists:foldl(
    fun(AgeA, Acc) ->
      MaxAgeB = AgeA - 14;

      NumRequests = lists:foldl(
        fun(AgeB, RequestCount) ->
          if
            AgeB > MaxAgeB andalso AgeB =< AgeA andalso (AgeB > 100 orelse AgeA < 100)
          then
            CountA = maps:get(AgeA, Counts, 0);
            CountB = maps:get(AgeB, Counts, 0);

            if AgeA == AgeB then
              RequestCount + CountA * (CountA - 1)
            else
              RequestCount + CountA * CountB
            end
          else
            RequestCount
          end
        end,
        0,
        maps:keys(Counts)
      );

      Acc + NumRequests
    end,
    0,
    maps:keys(Counts)
  ).