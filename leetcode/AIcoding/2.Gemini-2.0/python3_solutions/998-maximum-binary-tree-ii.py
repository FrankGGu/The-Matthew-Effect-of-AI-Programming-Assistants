class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def insertIntoMaxTree(self, root: TreeNode, val: int) -> TreeNode:
        node = TreeNode(val)
        if not root:
            return node

        if val > root.val:
            node.left = root
            return node

        curr = root
        while curr.right and curr.right.val > val:
            curr = curr.right

        node.left = curr.right
        curr.right = node

        return root