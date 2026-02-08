-module(leetcode).
-export([totalMoney/1]).

totalMoney(N) ->
    Weeks = N div 7,
    Remaining = N rem 7,
    7 * (Weeks * (Weeks + 7 - 1) div 2) + (Remaining * (Remaining + 2 * Weeks + 1) div 2).