class Node:
    def __init__(self, val, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def treeToDoublyList(self, root: 'Node') -> 'Node':
        if not root:
            return None

        self.head = None
        self.tail = None

        def inorder(node):
            if not node:
                return

            inorder(node.left)

            if not self.head:
                self.head = node
            else:
                self.tail.right = node
                node.left = self.tail

            self.tail = node

            inorder(node.right)

        inorder(root)

        self.head.left = self.tail
        self.tail.right = self.head

        return self.head