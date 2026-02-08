-module(solution).
-export([rob/1]).

rob(Houses) when length(Houses) == 0 -> 0;
rob(Houses) when length(Houses) == 1 -> hd(Houses);
rob(Houses) -> max(rob_helper(tl(Houses), hd(Houses), 0), rob_helper(init(Houses), 0, 0)).

rob_helper([], Prev1, Prev2) -> max(Prev1, Prev2);
rob_helper([H | T], Prev1, Prev2) -> 
    rob_helper(T, Prev2 + H, Prev1).

init([_ | T]) -> T.