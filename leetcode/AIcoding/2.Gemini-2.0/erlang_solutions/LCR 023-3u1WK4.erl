-module(intersection_of_two_linked_lists).
-export([getIntersectionNode/2]).

getIntersectionNode(HeadA, HeadB) ->
  getIntersectionNode_helper(HeadA, HeadB, HeadA, HeadB).

getIntersectionNode_helper(A, B, OriginalA, OriginalB) ->
  case {A, B} of
    {null, _} ->
      B;
    {_, null} ->
      A;
    {A, B} when A =:= B ->
      A;
    {A, B} ->
      NextA = case A of
        null ->
          OriginalB;
        {Val, Next} ->
          Next
      end,
      NextB = case B of
        null ->
          OriginalA;
        {Val, Next} ->
          Next
      end,
      getIntersectionNode_helper(NextA, NextB, OriginalA, OriginalB)
  end.