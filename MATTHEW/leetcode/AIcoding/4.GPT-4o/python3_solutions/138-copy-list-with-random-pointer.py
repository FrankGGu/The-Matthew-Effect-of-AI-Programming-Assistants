class Node:
    def __init__(self, val=0, next=None, random=None):
        self.val = val
        self.next = next
        self.random = random

class Solution:
    def copyRandomList(self, head: Node) -> Node:
        if not head:
            return None

        # First pass: copy nodes and insert them next to original nodes
        curr = head
        while curr:
            new_node = Node(curr.val)
            new_node.next = curr.next
            curr.next = new_node
            curr = new_node.next

        # Second pass: assign random pointers
        curr = head
        while curr:
            if curr.random:
                curr.next.random = curr.random.next
            curr = curr.next.next

        # Third pass: separate the two lists
        curr = head
        new_head = head.next
        while curr:
            new_node = curr.next
            curr.next = new_node.next
            if new_node.next:
                new_node.next = new_node.next.next
            curr = curr.next

        return new_head