-module(defangIPaddr).
-export([defang_i_paddr/1]).

defang_i_paddr(Address) ->
  string:join(string:split(Address, ".", all), "[.]").