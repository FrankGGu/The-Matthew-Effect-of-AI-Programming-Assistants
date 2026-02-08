class Node:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def treeToDoublyList(self, root: Node) -> Node:
        if not root:
            return None

        def inorder(node):
            nonlocal last, head
            if not node:
                return
            inorder(node.left)
            if last:
                last.right = node
                node.left = last
            else:
                head = node
            last = node
            inorder(node.right)

        last = None
        head = None
        inorder(root)
        head.left = last
        last.right = head
        return head