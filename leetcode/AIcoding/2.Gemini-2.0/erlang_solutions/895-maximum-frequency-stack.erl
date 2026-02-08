-module(max_freq_stack).
-export([new/0, push/2, pop/1]).

new() ->
  #{
    freqs => #{},
    stacks => #{}
  }.

push(Stack, X) ->
  #{freqs := Freqs, stacks := Stacks} = Stack,
  NewFreq = maps:get(X, Freqs, 0) + 1,
  NewFreqs = maps:put(X, NewFreq, Freqs),
  NewStacks =
    case maps:is_key(NewFreq, Stacks) of
      true ->
        maps:update(NewFreq, [X | maps:get(NewFreq, Stacks)], Stacks);
      false ->
        maps:put(NewFreq, [X], Stacks)
    end,
  #{
    freqs => NewFreqs,
    stacks => NewStacks,
    max_freq => max(maps:get(max_freq, Stack, 0), NewFreq)
  }.

pop(Stack) ->
  #{freqs := Freqs, stacks := Stacks, max_freq := MaxFreq} = Stack,
  [X | Rest] = maps:get(MaxFreq, Stacks),
  NewStacks =
    case Rest of
      [] ->
        maps:remove(MaxFreq, Stacks);
      _ ->
        maps:update(MaxFreq, Rest, Stacks)
    end,
  NewFreq = maps:get(X, Freqs) - 1,
  NewFreqs =
    case NewFreq of
      0 ->
        maps:remove(X, Freqs);
      _ ->
        maps:update(X, NewFreq, Freqs)
    end,
  NewMaxFreq =
    case maps:is_key(MaxFreq, NewStacks) of
      true ->
        MaxFreq;
      false ->
        find_max_freq(NewStacks)
    end,
  {X, #{
    freqs => NewFreqs,
    stacks => NewStacks,
    max_freq => NewMaxFreq
  }}.

find_max_freq(Stacks) ->
  find_max_freq(maps:keys(Stacks), 0).

find_max_freq([], Acc) ->
  Acc;
find_max_freq([H | T], Acc) ->
  find_max_freq(T, max(H, Acc)).