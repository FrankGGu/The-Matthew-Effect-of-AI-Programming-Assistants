-module(solution).
-export([insert_greatest_common_divisors/1]).

-record(list_node, {val, next}).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

insert_greatest_common_divisors(List) ->
  insert_greatest_common_divisors(List, null).

insert_greatest_common_divisors(null, _) ->
  null;
insert_greatest_common_divisors(#list_node{val = Val, next = Next} = Node, PrevNode) ->
  case PrevNode of
    null ->
      Node#list_node{next = insert_greatest_common_divisors(Next, Node)};
    _ ->
      GCD = gcd(PrevNode#list_node.val, Val),
      NewNode = #list_node{val = GCD, next = Node},
      PrevNode#list_node{next = NewNode},
      NewNode#list_node{next = insert_greatest_common_divisors(Next, Node)}
  end.