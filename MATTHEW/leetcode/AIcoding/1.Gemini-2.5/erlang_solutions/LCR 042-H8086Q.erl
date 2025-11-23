-module(recent_counter).
-export([init/0, ping/2]).

init() ->
    {[], [], 0}.

ping({Front, Back, Count}, T) ->
    NewBack = [T | Back],
    NewCount = Count + 1,

    LowerBound = T - 3000,

    {CleanFront, CleanBack, FinalCount} = clean_queue(Front, NewBack, NewCount, LowerBound),

    {{CleanFront, CleanBack, FinalCount}, FinalCount}.

clean_queue(Front, Back, CurrentCount, LowerBound) ->
    case Front of
        [] ->
            case Back of
                [] ->
                    {[], [], 0};
                _ ->
                    NewFront = lists:reverse(Back),
                    clean_queue(NewFront, [], CurrentCount, LowerBound)
            end;
        [Head | Tail] ->
            if Head < LowerBound ->
                    clean_queue(Tail, Back, CurrentCount - 1, LowerBound);
               true ->
                    {Front, Back, CurrentCount}
            end
    end.