-module(solution).
-export([change_data_type/1]).

change_data_type(N) when is_integer(N) -> integer_to_list(N);
change_data_type(S) when is_list(S) -> list_to_integer(S).