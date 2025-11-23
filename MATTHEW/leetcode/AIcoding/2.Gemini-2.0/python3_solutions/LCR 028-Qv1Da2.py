class Node:
    def __init__(self, val, prev, next, child):
        self.val = val
        self.prev = prev
        self.next = next
        self.child = child

class Solution:
    def flatten(self, head: 'Node') -> 'Node':
        if not head:
            return head

        def flatten_helper(node: 'Node') -> 'Node':
            curr = node
            tail = None

            while curr:
                next_node = curr.next

                if curr.child:
                    child_head = curr.child
                    child_tail = flatten_helper(child_head)

                    curr.next = child_head
                    child_head.prev = curr
                    curr.child = None

                    if next_node:
                        child_tail.next = next_node
                        next_node.prev = child_tail

                    curr = next_node if next_node else child_tail

                else:
                    curr = curr.next

            curr = node
            while curr and curr.next:
                curr = curr.next
            return curr

        flatten_helper(head)
        return head