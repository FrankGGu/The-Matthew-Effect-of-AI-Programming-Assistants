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

        # Step 1: Create new nodes and interleave them with the original nodes.
        # Original list: A -> B -> C
        # Modified list: A -> A' -> B -> B' -> C -> C'
        curr = head
        while curr:
            new_node = Node(curr.val, curr.next)
            curr.next = new_node
            curr = new_node.next

        # Step 2: Assign random pointers for the new nodes.
        # If original_node.random points to X, then new_node.random should point to X' (X.next).
        curr = head
        while curr:
            if curr.random:
                curr.next.random = curr.random.next
            curr = curr.next.next # Move to the next original node

        # Step 3: Separate the original list from the new list.
        # Restore original list: A -> B -> C
        # Form copy list: A' -> B' -> C'
        original_curr = head
        copy_head = head.next
        copy_curr = copy_head

        while original_curr:
            original_curr.next = copy_curr.next # Restore original list's next pointer

            # Link the copy_curr to the next copy node
            if original_curr.next: # If there's a next original node
                copy_curr.next = original_curr.next.next
            else: # This is the last node in the original list
                copy_curr.next = None

            original_curr = original_curr.next # Move to the next original node
            copy_curr = copy_curr.next # Move to the next copy node

        return copy_head