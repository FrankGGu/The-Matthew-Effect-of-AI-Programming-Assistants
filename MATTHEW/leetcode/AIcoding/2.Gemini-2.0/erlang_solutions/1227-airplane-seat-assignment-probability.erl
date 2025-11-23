-module(solution).
-export([nth_person_gets_nth_seat/1]).

nth_person_gets_nth_seat(1) ->
    1.0;
nth_person_gets_nth_seat(N) ->
    0.5.