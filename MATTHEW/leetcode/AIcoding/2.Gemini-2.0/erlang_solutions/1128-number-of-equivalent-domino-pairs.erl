-module(domino_pairs).
-export([numEquivDominoPairs/1]).

numEquivDominoPairs(Dominos) ->
  numEquivDominoPairs(Dominos, 0, []).

numEquivDominoPairs([], Count, _) ->
  Count;
numEquivDominoPairs([Domino | Rest], Count, Seen) ->
  {A, B} = Domino,
  SortedDomino = if A < B then {A, B} else {B, A} end,

  NewCount = case lists:member(SortedDomino, Seen) of
               true ->

                 Pairs = lists:filter(fun(D) -> 
                                          {X,Y} = D,
                                          SortedD = if X < Y then {X, Y} else {Y, X} end,
                                          SortedD == SortedDomino
                                      end, Seen),
                 Count + length(Pairs);
               false ->
                 Count
             end,

  numEquivDominoPairs(Rest, NewCount, [SortedDomino | Seen]).