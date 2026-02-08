-module(solution).
-export([connect/1]).

-type node() :: {integer(), node(), node(), node()} | none.

-spec connect(node()) -> node().
connect(Root) ->
  connect_level(Root),
  Root.

connect_level(none) ->
  ok;
connect_level(Node) ->
  connect_level_helper(Node),
  connect_level(get_left(Node)).

connect_level_helper(none) ->
  ok;
connect_level_helper(Node) ->
  case get_left(Node) of
    none -> ok;
    Left ->
      set_next(Left, get_right(Node)),
      NextRight = get_next(Node),
      case NextRight of
        none -> ok;
        NextRightNode ->
          set_next(get_right(Node), get_left(NextRightNode))
      end
  end,
  connect_level_helper(get_next(Node)).

get_left({Val, Left, Right, Next}) -> Left.
get_right({Val, Left, Right, Next}) -> Right.
get_next({Val, Left, Right, Next}) -> Next.
set_next({Val, Left, Right, Next}, NewNext) ->
  put({Val, Left, Right, NewNext}).

put({Val, Left, Right, Next}) ->
  {Val, Left, Right, Next}.