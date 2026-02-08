class Node:
    def __init__(self, val, prev, next, child):
        self.val = val
        self.prev = prev
        self.next = next
        self.child = child

class Solution:
    def flatten(self, head: 'Optional[Node]') -> 'Optional[Node]':
        def flatten_recursive(head: 'Optional[Node]') -> 'Optional[Node]':
            curr = head
            tail = None
            while curr:
                tail = curr
                if curr.child:
                    child_head = curr.child
                    child_tail = flatten_recursive(child_head)
                    curr.child = None

                    next_node = curr.next
                    curr.next = child_head
                    child_head.prev = curr

                    if next_node:
                        child_tail.next = next_node
                        next_node.prev = child_tail

                    curr = next_node
                    tail = child_tail

                else:
                    curr = curr.next
            return tail

        if not head:
            return None

        flatten_recursive(head)
        return head