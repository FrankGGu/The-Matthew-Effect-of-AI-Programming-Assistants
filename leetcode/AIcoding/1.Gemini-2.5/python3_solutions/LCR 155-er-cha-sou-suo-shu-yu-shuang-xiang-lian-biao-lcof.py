"""
class Node:
    def __init__(self, val, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right
"""

class Solution:
    def treeToDoublyList(self, root: 'Node') -> 'Node':
        if not root:
            return None

        self.head = None
        self.prev = None

        def inorder(node):
            if not node:
                return

            inorder(node.left)

            if self.prev is None:
                self.head = node
            else:
                self.prev.right = node
                node.left = self.prev

            self.prev = node

            inorder(node.right)

        inorder(root)

        self.head.left = self.prev
        self.prev.right = self.head

        return self.head