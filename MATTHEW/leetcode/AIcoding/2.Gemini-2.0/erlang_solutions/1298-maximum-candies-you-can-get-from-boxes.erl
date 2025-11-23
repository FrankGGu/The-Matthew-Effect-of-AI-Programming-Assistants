-module(maximum_candies).
-export([max_candies/4]).

max_candies(Boxes, Keys, Locked, Candies) ->
  max_candies(Boxes, Keys, Locked, Candies, [0], 0, []).

max_candies(Boxes, Keys, Locked, Candies, OpenBoxes, TotalCandies, Visited) ->
  case OpenBoxes of
    [] ->
      TotalCandies;
    [BoxId | RestOpenBoxes] ->
      case lists:member(BoxId, Visited) of
        true ->
          max_candies(Boxes, Keys, Locked, Candies, RestOpenBoxes, TotalCandies, Visited);
        false ->
          case lists:nth(BoxId + 1, Locked) of
            1 ->
              case lists:member(BoxId, Keys) of
                true ->
                  NewKeys = lists:filter(fun(Key) -> Key /= BoxId end, Keys),
                  NewTotalCandies = TotalCandies + lists:nth(BoxId + 1, Candies),
                  NewKeysFromBox = lists:nth(BoxId + 1, Boxes),
                  NewOpenBoxes = RestOpenBoxes ++ NewKeysFromBox,
                  max_candies(Boxes, NewKeys, Locked, Candies, NewOpenBoxes, NewTotalCandies, [BoxId | Visited]);
                false ->
                  max_candies(Boxes, Keys, Locked, Candies, RestOpenBoxes, TotalCandies, [BoxId | Visited])
              end;
            0 ->
              NewTotalCandies = TotalCandies + lists:nth(BoxId + 1, Candies),
              NewKeysFromBox = lists:nth(BoxId + 1, Boxes),
              NewOpenBoxes = RestOpenBoxes ++ NewKeysFromBox,
              max_candies(Boxes, Keys, Locked, Candies, NewOpenBoxes, NewTotalCandies, [BoxId | Visited])
          end
      end
  end.