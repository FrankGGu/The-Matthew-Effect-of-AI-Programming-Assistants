-module(defang_ip_address).
-export([defang_ip_address/1]).

defang_ip_address(IP) ->
    lists:flatten([if C == $. -> "[.]"; true -> [C] end || C <- IP]).