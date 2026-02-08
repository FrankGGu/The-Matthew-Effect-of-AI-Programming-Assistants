"""
class Node:
    def __init__(self, x: int, next: 'Node' = None, random: 'Node' = None):
        self.val = int(x)
        self.next = next
        self.random = random
"""

class Solution:
    def copyRandomList(self, head: 'Optional[Node]') -> 'Optional[Node]':
        if not head:
            return None

        # Step 1: Create new nodes and interleave them with the original list
        # A -> B -> C becomes A -> A' -> B -> B' -> C -> C'
        current = head
        while current:
            new_node = Node(current.val, current.next, None)
            current.next = new_node
            current = new_node.next

        # Step 2: Assign random pointers for the new nodes
        # A' random should point to B' if A random points to B
        current = head
        while current:
            if current.random:
                current.next.random = current.random.next
            current = current.next.next

        # Step 3: Separate the original list from the copied list
        original_current = head
        copied_head = head.next
        copied_current = copied_head

        while original_current:
            original_current.next = copied_current.next
            if copied_current.next:
                copied_current.next = copied_current.next.next
            else:
                copied_current.next = None # Last node in copied list

            original_current = original_current.next
            copied_current = copied_current.next

        return copied_head