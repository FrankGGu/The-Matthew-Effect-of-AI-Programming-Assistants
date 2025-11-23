-module(latest_time).
-export([latest_time/1]).

latest_time(Time) ->
  list_to_binary(latest_time_helper(binary_to_list(Time))).

latest_time_helper([H1, H2, $:, M1, M2]) ->
  {HH1, HH2} = get_hours(H1, H2),
  {MM1, MM2} = get_minutes(M1, M2),
  [HH1, HH2, $:, MM1, MM2].

get_hours($?, $?) -> {50, 51};
get_hours($?, H2) when H2 >= $0, H2 =< $3 -> {50, $3};
get_hours($?, H2) when H2 >= $4, H2 =< $9 -> {49, H2};
get_hours(H1, $?) when H1 >= $0, H1 =< $1 -> {H1, $9};
get_hours(H1, $?) when H1 == $2 -> {H1, $3};
get_hours($0, H2) -> {$0, H2};
get_hours($1, H2) -> {$1, H2};
get_hours($2, H2) -> {$2, H2};
get_hours(H1, H2) -> {H1, H2}.

get_minutes($?, $?) -> {53, 57};
get_minutes($?, M2) -> {53, M2};
get_minutes(M1, $?) -> {M1, $9};
get_minutes(M1, M2) -> {M1, M2}.