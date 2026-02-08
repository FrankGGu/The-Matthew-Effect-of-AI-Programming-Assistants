class Node:
    def __init__(self, val=0, next=None, random=None):
        self.val = val
        self.next = next
        self.random = random

class Solution:
    def copyRandomList(self, head: Node) -> Node:
        if not head:
            return None

        # Step 1: Create a mapping from old nodes to new nodes
        old_to_new = {}
        current = head

        while current:
            old_to_new[current] = Node(current.val)
            current = current.next

        # Step 2: Set next and random pointers for the new nodes
        current = head

        while current:
            new_node = old_to_new[current]
            new_node.next = old_to_new.get(current.next)
            new_node.random = old_to_new.get(current.random)
            current = current.next

        return old_to_new[head]