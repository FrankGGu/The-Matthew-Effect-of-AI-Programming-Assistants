class Node:
    def __init__(self, x: int, next: 'Node' = None, random: 'Node' = None):
        self.val = int(x)
        self.next = next
        self.random = random

class Solution:
    def copyRandomList(self, head: 'Node') -> 'Node':
        if not head:
            return None

        node_map = {}
        current = head
        while current:
            node_map[current] = Node(current.val)
            current = current.next

        current = head
        while current:
            new_node = node_map[current]
            new_node.next = node_map.get(current.next)
            new_node.random = node_map.get(current.random)
            current = current.next

        return node_map[head]