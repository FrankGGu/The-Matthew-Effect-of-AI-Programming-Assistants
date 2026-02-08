-module(invalid_transactions).
-export([invalid_transactions/1]).

invalid_transactions(Transactions) ->
  Parsed = [parse_transaction(T) || T <- Transactions],
  Invalid = [T || T <- Parsed, is_invalid(T, Parsed)],
  [format_transaction(T) || T <- Invalid].

parse_transaction(Transaction) ->
  [Name, TimeStr, AmountStr, City] = string:tokens(Transaction, ","),
  {list_to_atom(Name), list_to_integer(TimeStr), list_to_integer(AmountStr), list_to_atom(City)}.

format_transaction({Name, Time, Amount, City}) ->
  list_to_binary(atom_to_list(Name) ++ "," ++ integer_to_list(Time) ++ "," ++ integer_to_list(Amount) ++ "," ++ atom_to_list(City)).

is_invalid({Name, Time, Amount, City}, Transactions) ->
  Amount > 1000 orelse lists:any(fun({OtherName, OtherTime, OtherAmount, OtherCity}) ->
                                      Name == OtherName andalso
                                        abs(Time - OtherTime) <= 60 andalso
                                        City /= OtherCity
                                  end, Transactions).