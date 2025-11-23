-module(solution).
-compile([export_all]).

-record(nested_integer, {is_integer, value, list}).

% Create a new NestedInteger
new() -> #nested_integer{is_integer = true, value = 0, list = []}.
new(Value) when is_integer(Value) -> #nested_integer{is_integer = true, value = Value, list = []}.
new(List) when is_list(List) -> #nested_integer{is_integer = false, value = 0, list = List}.

% Check if the NestedInteger holds a single integer
is_integer(#nested_integer{is_integer = true}) -> true;
is_integer(_) -> false.

% Get the integer value from NestedInteger
get_integer(#nested_integer{is_integer = true, value = Value}) -> Value;
get_integer(_) -> undefined.

% Get the list from NestedInteger
get_list(#nested_integer{is_integer = false, list = List}) -> List;
get_list(_) -> undefined.

% Deserialize the input string into a NestedInteger
deserialize(S) -> deserialize(S, []).

deserialize(<<"">>, _) -> undefined; % Empty string case
deserialize(<<S/binary>>, Acc) when S =:= $[ or S =:= $] -> deserialize(rest, Acc);
deserialize(S, Acc) -> 
    process(S, Acc).

process(S, Acc) -> 
    % Processing function will follow rules
