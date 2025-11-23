-module(solution).
-export([max_score/2]).

max_score(Students, Mentors) ->
    N = length(Students),
    Perms = permutations(lists:seq(0, N-1)),
    lists:foldl(fun(Perm, Acc) ->
        Score = score(Students, Mentors, Perm),
        max(Acc, Score)
    end, -1, Perms).

permutations([]) -> [[]];
permutations(L) ->
    [ [H | T] || H <- L, T <- permutations(lists:delete(H, L)) ].

score(_, _, []) -> 0;
score(Students, Mentors, [I | Is]) ->
    Student = lists:nth(I + 1, Students),
    Mentor = lists:nth(I + 1, Mentors),
    Sum = lists:sum([A * B || {A, B} <- lists:zip(Student, Mentor)]),
    Sum + score(Students, Mentors, Is).

max(A, B) when A > B -> A;
max(_, B) -> B.