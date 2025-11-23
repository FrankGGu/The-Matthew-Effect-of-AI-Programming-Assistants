-module(solution).
-export([isValidSerialization/1]).

isValidSerialization(Preorder) ->
    Tokens = string:tokens(Preorder, ","),
    case Tokens of
        [] -> false; % An empty string is not a valid serialization
        _ ->
            % Initial degree is 1, representing the slot for the root node.
            check_tokens(Tokens, 1)
    end.

check_tokens([], 0) ->
    % All tokens processed and the degree is exactly 0, meaning all slots were filled correctly.
    true;
check_tokens([], _) ->
    % All tokens processed, but the degree is not 0 (either too many or too few nodes).
    false;
check_tokens([Token | Rest], CurrentDegree) when CurrentDegree =< 0 ->
    % If the degree is 0 or negative before processing the current token,
    % it means we've either filled all available slots prematurely or
    % tried to fill a non-existent slot. In either case, it's invalid.
    false;
check_tokens([Token | Rest], CurrentDegree) ->
    % CurrentDegree must be > 0 here due to the previous guard.
    NewDegree =
        case Token of
            "#" ->
                % A null node consumes one slot.
                CurrentDegree - 1;
            _ ->
                % A non-null node consumes one slot and provides two new slots for its children.
                % Net effect: CurrentDegree - 1 + 2 = CurrentDegree + 1.
                CurrentDegree + 1
        end,
    check_tokens(Rest, NewDegree).