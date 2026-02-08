-module(solution).
-export([canTransform/2]).

canTransform(Start, End) ->
    StartList = string:to_list(Start),
    EndList = string:to_list(End),
    can_transform(StartList, EndList).

can_transform([], []) -> true;
can_transform([H1 | T1], [H2 | T2]) when H1 =:= H2 -> can_transform(T1, T2);
can_transform([H1 | T1], [H2 | T2]) when H1 =:= $X, H2 =:= $L -> 
    can_transform(T1, [H2 | T2]);
can_transform([H1 | T1], [H2 | T2]) when H1 =:= $R, H2 =:= $X -> 
    can_transform([H1 | T1], T2);
can_transform([H1 | T1], [H2 | T2]) when H1 =:= $L, H2 =:= $X -> 
    can_transform(T1, [H2 | T2]);
can_transform([H1 | T1], [H2 | T2]) when H1 =:= $X, H2 =:= $R -> 
    can_transform([H1 | T1], T2);
can_transform([H1 | T1], [H2 | T2]) -> false.