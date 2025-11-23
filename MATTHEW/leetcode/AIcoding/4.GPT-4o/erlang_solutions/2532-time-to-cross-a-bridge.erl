-module(solution).
-export([cross_bridge/2]).

cross_bridge(bridge_length, speed) ->
    bridge_length div speed + (if 
        bridge_length rem speed =:= 0 -> 0; 
        true -> 1 
    end).