%% Implementing Queue using Stacks in Erlang

%% Initialize an empty queue (using two stacks)
-spec my_queue_init_() -> {list(), list()}.
my_queue_init_() -> 
    {[], []}.

%% Push operation - Push an element to the back of the queue
-spec my_queue_push({list(), list()}, integer()) -> {list(), list()}.
my_queue_push({In, Out}, X) -> 
    { [X | In], Out }.

%% Pop operation - Remove the element from the front of the queue
-spec my_queue_pop({list(), list()}) -> integer().
my_queue_pop({[], []}) -> 
    exit("Queue is empty");
my_queue_pop({In, []}) -> 
    my_queue_pop({[], lists:reverse(In)});
my_queue_pop({In, [H | T]}) -> 
    H.

%% Peek operation - Get the element at the front of the queue without removing it
-spec my_queue_peek({list(), list()}) -> integer().
my_queue_peek({[], []}) -> 
    exit("Queue is empty");
my_queue_peek({In, []}) -> 
    my_queue_peek({[], lists:reverse(In)});
my_queue_peek({In, [H | _]}) -> 
    H.

%% Empty operation - Check if the queue is empty
-spec my_queue_empty({list(), list()}) -> boolean().
my_queue_empty({[], []}) -> 
    true;
my_queue_empty(_) -> 
    false.
