-module(unhappy_friends).
-export([unhappy_friends/2]).

unhappy_friends(N, Preferences) ->
  unhappy_friends_helper(N, Preferences, []).

unhappy_friends_helper(_N, Preferences, Acc) ->
  lists:foldl(fun(Friend, Acc1) ->
                  find_unhappy(Friend, Preferences, Acc1)
              end, 0, lists:seq(0, length(Preferences) - 1)).

find_unhappy(Friend, Preferences, Acc) ->
  Pref = lists:nth(Friend + 1, Preferences),
  Partner = get_partner(Friend, Preferences),
  PartnerPref = lists:nth(Partner + 1, Preferences),
  case find_better_pair(Friend, Partner, Pref, Preferences) of
    true ->
      Acc + 1;
    false ->
      Acc
  end.

find_better_pair(Friend, Partner, Pref, Preferences) ->
  lists:any(fun(X) ->
                X /= Partner andalso
                  (lists:member(X, lists:sublist(Pref, 1, lists:index(Pref, Partner) - 1)) andalso
                     let
                       XPartner = get_partner(X, Preferences),
                       XPref = lists:nth(X + 1, Preferences)
                     in
                       lists:member(Friend, lists:sublist(XPref, 1, lists:index(XPref, XPartner) - 1))
                     end)
            end, lists:seq(0, length(Preferences) - 1)).

get_partner(Friend, Preferences) ->
  lists:foldl(fun(F, Acc) ->
                  case lists:member(Friend, lists:nth(F + 1, Preferences)) of
                    true ->
                      case lists:member(F, lists:nth(Friend + 1, Preferences)) of
                        true ->
                          Acc;
                        false ->
                          F
                      end;
                    false ->
                      Acc
                  end
              end, -1, lists:seq(0, length(Preferences) - 1)).