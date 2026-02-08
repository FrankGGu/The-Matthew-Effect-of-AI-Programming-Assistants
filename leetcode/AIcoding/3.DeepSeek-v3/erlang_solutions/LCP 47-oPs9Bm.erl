-module(solution).
-export([security_check/1]).

security_check(People) ->
    Q = queue:new(),
    process_people(People, Q).

process_people([], Q) ->
    queue:to_list(Q);
process_people([P | Rest], Q) ->
    case P of
        $0 -> 
            NewQ = queue:in(P, Q),
            process_people(Rest, NewQ);
        $1 ->
            NewQ = queue:in(P, Q),
            process_people(Rest, NewQ);
        $2 ->
            {Front, Rear} = queue:split(queue:len(Q) div 2, Q),
            NewQ = queue:join(Front, queue:in(P, Rear)),
            process_people(Rest, NewQ)
    end.