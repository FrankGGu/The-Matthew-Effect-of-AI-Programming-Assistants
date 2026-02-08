"""
class Node:
    def __init__(self, val, prev, next, child):
        self.val = val
        self.prev = prev
        self.next = next
        self.child = child
"""

class Solution:
    def flatten(self, head: 'Node') -> 'Node':
        if not head:
            return head

        self._flatten_and_get_tail(head) 
        return head

    def _flatten_and_get_tail(self, node: 'Node') -> 'Node':
        curr = node
        tail = node

        while curr:
            tail = curr

            if curr.child:
                next_node = curr.next

                child_head = curr.child
                curr.next = child_head
                child_head.prev = curr
                curr.child = None

                flattened_child_tail = self._flatten_and_get_tail(child_head)

                if next_node:
                    flattened_child_tail.next = next_node
                    next_node.prev = flattened_child_tail

                tail = flattened_child_tail
                curr = flattened_child_tail

            curr = curr.next

        return tail