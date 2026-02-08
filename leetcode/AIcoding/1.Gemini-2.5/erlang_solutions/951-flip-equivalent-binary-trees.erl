-module(solution).
-export([is_flip_equivalent/2]).

-record('TreeNode', {val = 0, left = nil, right = nil}).

is_flip_equivalent(nil, nil) ->
    true;
is_flip_equivalent(nil, _) ->
    false;
is_flip_equivalent(_, nil) ->
    false;
is_flip_equivalent(#'TreeNode'{val = V1, left = L1, right = R1}, #'TreeNode'{val = V2, left = L2, right = R2}) ->
    if V1 == V2 ->
        (is_flip_equivalent(L1, L2) andalso is_flip_equivalent(R1, R2)) orelse
        (is_flip_equivalent(L1, R2) andalso is_flip_equivalent(R1, L2));
    true ->
        false
    end.