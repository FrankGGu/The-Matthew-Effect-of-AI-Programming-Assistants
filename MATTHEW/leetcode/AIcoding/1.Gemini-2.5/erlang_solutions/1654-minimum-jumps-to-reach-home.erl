-module(solution).
-export([minimum_jumps/4]).

minimum_jumps(A, B, X, ForbiddenList) ->
    Forbidden = gb_sets:from_list(ForbiddenList),

    MaxForbiddenVal = case ForbiddenList of
                          [] -> 0;
                          _ -> lists:max(ForbiddenList)
                      end,

    % Determine the maximum coordinate to explore.
    % A common and effective upper bound for this problem is max(X, MaxForbiddenVal) + A.
    % This bound ensures that we can explore positions up to X,
    % jump over any forbidden spots, and also account for a forward jump 'A'
    % from X or the largest forbidden position.
    % Any position beyond this limit is generally not useful to explore further
    % due to the constraint of not jumping backward twice.
    MaxLimit = max(X, MaxForbiddenVal) + A,

    Q = queue:from_list([{0, false, 0}]), % {Pos, LastJumpWasBackward, JumpsCount}
    V = gb_sets:add({0, false}, gb_sets:empty()), % {{Pos, LastJumpWasBackward}}

    bfs(Q, V, A, B, X, Forbidden, MaxLimit).

bfs(Q, V, A, B, X, Forbidden, MaxLimit) ->
    case queue:out(Q) of
        {{value, {CurrentPos, LastBackward, Jumps}}, RestQ} ->
            if CurrentPos == X ->
                Jumps;
            true ->
                NewQ = RestQ,
                NewV = V,

                % 1. Try jumping forward
                NextPosForward = CurrentPos + A,
                {UpdatedQ1, UpdatedV1} =
                    if NextPosForward >= 0 andalso NextPosForward =< MaxLimit andalso not gb_sets:is_element(NextPosForward, Forbidden) andalso not gb_sets:is_element({NextPosForward, false}, NewV) ->
                        {queue:in({NextPosForward, false, Jumps + 1}, NewQ), gb_sets:add({NextPosForward, false}, NewV)};
                    true ->
                        {NewQ, NewV}
                    end,

                % 2. Try jumping backward (only if the last jump was not backward)
                {UpdatedQ2, UpdatedV2} =
                    if not LastBackward ->
                        NextPosBackward = CurrentPos - B,
                        if NextPosBackward >= 0 andalso NextPosBackward =< MaxLimit andalso not gb_sets:is_element(NextPosBackward, Forbidden) andalso not gb_sets:is_element({NextPosBackward, true}, UpdatedV1) ->
                            {queue:in({NextPosBackward, true, Jumps + 1}, UpdatedQ1), gb_sets:add({NextPosBackward, true}, UpdatedV1)};
                        true ->
                            {UpdatedQ1, UpdatedV1}
                        end;
                    true ->
                        {UpdatedQ1, UpdatedV1}
                    end,

                bfs(UpdatedQ2, UpdatedV2, A, B, X, Forbidden, MaxLimit)
            end;
        {empty, _} ->
            -1 % Target not reachable
    end.