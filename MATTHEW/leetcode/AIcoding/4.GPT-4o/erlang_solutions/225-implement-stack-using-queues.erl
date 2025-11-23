%% Implementing Stack using Two Queues
%% The stack will be implemented using two queues: queue1 and queue2.
%% The idea is to always push the new element into queue2, then move all elements from queue1 to queue2, and swap the queues.

-record(queue, {queue = []}).

-spec my_stack_init() -> any().
my_stack_init() ->
    {queue1, queue2}.

-spec my_stack_push({queue, queue}, integer()) -> {queue, queue}.
my_stack_push({queue1, queue2}, X) ->
    Queue2New = [X | queue2],
    {Queue2New, queue1}.

-spec my_stack_pop({queue, queue}) -> integer().
my_stack_pop({[], Queue2}) -> 
    hd(Queue2);
my_stack_pop({[H | T], Queue2}) -> 
    my_stack_pop({T, [H | Queue2]}).

-spec my_stack_top({queue, queue}) -> integer().
my_stack_top({[], Queue2}) -> 
    hd(Queue2);
my_stack_top({[H | T], Queue2}) -> 
    my_stack_top({T, [H | Queue2]}).

-spec my_stack_empty({queue, queue}) -> boolean().
my_stack_empty({[], []}) -> true;
my_stack_empty(_) -> false.
