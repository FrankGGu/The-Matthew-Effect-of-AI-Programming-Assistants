-module(alert_names).
-export([alert_names/1]).

alert_names(KeyNameLog) ->
  Alerts = find_alerts(KeyNameLog),
  lists:sort(Alerts).

find_alerts(KeyNameLog) ->
  NameTimes = lists:map(fun({Name, Time}) ->
    {Name, to_minutes(Time)}
  end, KeyNameLog),

  NameMap = lists:foldl(fun({Name, Time}, Acc) ->
    case maps:is_key(Name, Acc) of
      true ->
        maps:update(Name, [Time | maps:get(Name, Acc)], Acc);
      false ->
        maps:put(Name, [Time], Acc)
    end
  end, #{}, NameTimes),

  Alerts = lists:foldl(fun({Name, Times}, Acc) ->
    SortedTimes = lists:sort(Times),
    case check_alerts(SortedTimes) of
      true ->
        [Name | Acc];
      false ->
        Acc
    end
  end, [], maps:to_list(NameMap)),

  Alerts.

check_alerts(Times) ->
  check_alerts(Times, []).

check_alerts([], _) ->
  false;
check_alerts([T1, T2, T3 | Rest], Acc) ->
  case T3 - T1 =< 60 of
    true ->
      true;
    false ->
      check_alerts([T2, T3 | Rest], Acc)
  end;
check_alerts([_], _) ->
  false;
check_alerts([_, _], _) ->
  false.

to_minutes(Time) ->
  [H, M] = string:split(Time, ":", all),
  Hour = list_to_integer(H),
  Minute = list_to_integer(M),
  Hour * 60 + Minute.