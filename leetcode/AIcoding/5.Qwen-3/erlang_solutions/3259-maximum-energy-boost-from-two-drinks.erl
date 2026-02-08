-module(max_energy_boost).
-export([maxEnergy/1]).

maxEnergy(Drinks) ->
    maxEnergy(Drinks, 0, 0).

maxEnergy([], A, B) ->
    max(A, B);
maxEnergy([H | T], A, B) ->
    NewA = B + H,
    NewB = max(A, B),
    maxEnergy(T, NewA, NewB).