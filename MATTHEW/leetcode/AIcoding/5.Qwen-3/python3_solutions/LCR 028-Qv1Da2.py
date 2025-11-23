class Node:
    def __init__(self, val, prev, next, child):
        self.val = val
        self.prev = prev
        self.next = next
        self.child = child

class Solution:
    def flatten(self, head: 'Node') -> 'Node':
        if not head:
            return None

        dummy = Node(0, None, head, None)
        prev = dummy

        def dfs(node):
            nonlocal prev
            if not node:
                return
            next_node = node.next
            node.prev = prev
            prev.next = node
            prev = node
            dfs(node.child)
            node.child = None
            dfs(next_node)

        dfs(head)
        dummy.next.prev = None
        return dummy.next