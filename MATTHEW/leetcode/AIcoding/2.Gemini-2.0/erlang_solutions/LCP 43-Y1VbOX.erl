-module(crosswalk).
-export([solution/1]).

solution(Requests) ->
  solution(Requests, []).

solution([], Queue) ->
  lists:reverse(Queue);
solution([{A, B}|Rest], Queue) ->
  solution(Rest, [solve(A, B) | Queue]).

solve(1, _) -> 1;
solve(2, _) -> 2;
solve(3, _) -> 3;
solve(4, _) -> 4;
solve(A, B) when A < B -> A;
solve(A, B) when A > B -> B.