-module(stock_span).
-export([new/0, next/2]).

-record(state, {stack = []}).

new() ->
  #state{}.

next(Price, State) ->
  {Span, NewStack} = next_helper(Price, State#state.stack, 1, []),
  NewState = State#state{stack = lists:reverse(NewStack)},
  {Span, NewState}.

next_helper(Price, [], Acc, AccStack) ->
  {Acc, [{Price, Acc} | AccStack]};
next_helper(Price, [{PrevPrice, PrevSpan} | Rest], Acc, AccStack) ->
  case Price >= PrevPrice of
    true ->
      next_helper(Price, Rest, Acc + PrevSpan, AccStack);
    false ->
      {Acc, [{Price, Acc} | [{PrevPrice, PrevSpan} | AccStack]]}
  end.