-module(is_substructure).
-export([is_subStructure/2]).

is_subStructure(A, B) ->
  case B of
    null -> true;
    _ ->
      is_subStructure_helper(A, B)
  end.

is_subStructure_helper(null, _) -> false;
is_subStructure_helper(A, B) ->
  is_same_structure(A, B) orelse is_subStructure_helper(A@>left, B) orelse is_subStructure_helper(A@>right, B).

is_same_structure(null, null) -> true;
is_same_structure(_, null) -> true;
is_same_structure(null, _) -> false;
is_same_structure(A, B) ->
  A@>val == B@>val andalso is_same_structure(A@>left, B@>left) andalso is_same_structure(A@>right, B@>right).