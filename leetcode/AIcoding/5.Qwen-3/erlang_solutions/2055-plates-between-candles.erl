-module(plates_between_candles).
-export([calculate/2]).

calculate(Plates, Queries) ->
    N = length(Plates),
    Left = left_positions(Plates, N),
    Right = right_positions(Plates, N),
    Prefix = prefix_sum(Plates, N),
    Results = lists:map(fun(Q) -> query(Q, Left, Right, Prefix, N) end, Queries),
    Results.

left_positions(_, 0) -> [];
left_positions(Plates, N) ->
    [0 | left_positions(Plates, N-1)].

right_positions(_, 0) -> [];
right_positions(Plates, N) ->
    [N-1 | right_positions(Plates, N-1)].

prefix_sum(_, 0) -> [];
prefix_sum(Plates, N) ->
    [lists:nth(N, Plates) + lists:nth(N-1, prefix_sum(Plates, N-1)) | prefix_sum(Plates, N-1)].

query({L, R}, Left, Right, Prefix, N) ->
    if
        L >= R -> 0;
        true ->
            Left_L = lists:nth(L+1, Left),
            Right_R = lists:nth(R+1, Right),
            if
                Left_L >= R -> 0;
                true ->
                    Count = lists:nth(Right_R+1, Prefix) - lists:nth(Left_L, Prefix),
                    Count
            end
    end.