-module(solution).
-export([find_content_children/2]).

-spec find_content_children([integer()], [integer()]) -> integer().
find_content_children(G, S) ->
    %% Sort the greed factors and cookie sizes.
    G_sorted = lists:sort(G),
    S_sorted = lists:sort(S),
    %% Call the helper function to find the maximum content children.
    find_content_children(G_sorted, S_sorted, 0, 0).

%% Helper function to find the number of content children.
-spec find_content_children([integer()], [integer()], integer(), integer()) -> integer().
find_content_children([], _, ContentCount, _) -> ContentCount;
find_content_children(_, [], ContentCount, _) -> ContentCount;
find_content_children([G | GRest], [S | SRest], ContentCount, Index) when S >= G ->
    %% Assign the cookie to the child, increase the count, and move to the next child and cookie.
    find_content_children(GRest, SRest, ContentCount + 1, Index + 1);
find_content_children([G | GRest], [_ | SRest], ContentCount, Index) ->
    %% Skip the cookie if it's too small for the current child.
    find_content_children([G | GRest], SRest, ContentCount, Index + 1).
