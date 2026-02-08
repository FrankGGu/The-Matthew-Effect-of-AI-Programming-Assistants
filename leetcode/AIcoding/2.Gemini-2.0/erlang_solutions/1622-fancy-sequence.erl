-module(fancy_sequence).
-export([start/1, append/2, add_all/2, mult_all/2, get_idx/2]).

start(MaxN) ->
  {ok, Pid} = gen_server:start_link(?MODULE, [MaxN, [], 1, 0], []),
  Pid.

append(Pid, Val) ->
  gen_server:call(Pid, {append, Val}).

add_all(Pid, Inc) ->
  gen_server:call(Pid, {add_all, Inc}).

mult_all(Pid, M) ->
  gen_server:call(Pid, {mult_all, M}).

get_idx(Pid, Idx) ->
  gen_server:call(Pid, {get_idx, Idx}).

init([MaxN, Seq, M, A]) ->
  {ok, {MaxN, Seq, M, A}}.

handle_call({append, Val}, _From, State = {MaxN, Seq, M, A}) ->
  NewSeq = [{{M, A}, Val} | Seq],
  case length(NewSeq) > MaxN of
    true ->
      {reply, null, {MaxN, lists:droplast(NewSeq), M, A}};
    false ->
      {reply, null, {MaxN, NewSeq, M, A}}
  end;

handle_call({add_all, Inc}, _From, State = {MaxN, Seq, M, A}) ->
  {reply, null, {MaxN, Seq, M, (A + Inc) rem 1000000007}};

handle_call({mult_all, Mult}, _From, State = {MaxN, Seq, M, A}) ->
  NewM = (M * Mult) rem 1000000007,
  NewA = (A * Mult) rem 1000000007,
  {reply, null, {MaxN, Seq, NewM, NewA}};

handle_call({get_idx, Idx}, _From, State = {MaxN, Seq, M, A}) ->
  case lists:nth(Idx + 1, lists:reverse(Seq), undefined) of
    {{ElemM, ElemA}, Val} ->
      Result = (Val * M + A - ElemA) rem 1000000007 * mod_inverse(ElemM, 1000000007) rem 1000000007,
      {reply, Result, State};
    undefined ->
      {reply, -1, State}
  end;
handle_call(_Request, _From, State) ->
  {reply, null, State}.

handle_info(_Info, State) ->
  {noreply, State}.

mod_inverse(A, M) ->
  mod_inverse_helper(A, M, 1, 0).

mod_inverse_helper(A, M, X, Y) ->
  case A of
    0 ->
      if M == 1 ->
        X rem 1000000007;
      true ->
        -1
      end;
    _ ->
      T = M div A,
      NewM = A,
      NewA = M rem A,
      NewY = X - T * Y,
      NewX = Y,
      mod_inverse_helper(NewA, NewM, NewX, NewY)
  end.