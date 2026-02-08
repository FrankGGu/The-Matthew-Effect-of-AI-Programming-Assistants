-spec insert_greatest_common_divisors(Head :: #list_node{} | null) -> #list_node{} | null.
insert_greatest_common_divisors(null) -> null;
insert_greatest_common_divisors(Head) ->
    insert_gcd(Head).

insert_gcd(Node) when Node#list_node.next =:= null -> Node;
insert_gcd(Node) ->
    Next = Node#list_node.next,
    Gcd = gcd(Node#list_node.val, Next#list_node.val),
    NewNode = #list_node{val = Gcd, next = Next},
    Node#list_node{next = NewNode},
    insert_gcd(Next).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).