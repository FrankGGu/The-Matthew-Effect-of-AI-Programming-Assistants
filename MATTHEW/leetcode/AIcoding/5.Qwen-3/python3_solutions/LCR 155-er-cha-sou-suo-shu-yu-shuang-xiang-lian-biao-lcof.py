class Node:
    def __init__(self, val, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def treeToDoublyList(self, root: 'Node') -> 'Node':
        if not root:
            return None

        self.prev = None
        self.head = None

        def dfs(node):
            if not node:
                return
            dfs(node.left)
            if self.prev:
                self.prev.right = node
                node.left = self.prev
            else:
                self.head = node
            self.prev = node
            dfs(node.right)

        dfs(root)
        self.head.left = self.prev
        self.prev.right = self.head
        return self.head