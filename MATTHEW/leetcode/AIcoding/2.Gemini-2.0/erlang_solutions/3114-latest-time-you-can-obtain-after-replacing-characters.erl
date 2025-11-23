-module(latest_time).
-export([maximum_time_after_replacement/1]).

maximum_time_after_replacement(Time) ->
  [H1, H2, ':', M1, M2] = string:to_list(Time),

  Max_H1 = case H1 of
              '?' ->
                case H2 of
                  '?' -> '2';
                  H when H >= '0', H =< '3' -> '2';
                  _ -> '1'
                end;
              _ -> H1
            end,

  Max_H2 = case H2 of
              '?' ->
                case Max_H1 of
                  '2' -> '3';
                  _ -> '9'
                end;
              _ -> H2
            end,

  Max_M1 = case M1 of
              '?' -> '5';
              _ -> M1
            end,

  Max_M2 = case M2 of
              '?' -> '9';
              _ -> M2
            end,

  list_to_binary([Max_H1, Max_H2, ':', Max_M1, Max_M2]).