-module(solution).
-export([find_center/1]).

find_center([[A,B]|_]) when A == B -> A;
find_center([[A,B]|_]) -> A.