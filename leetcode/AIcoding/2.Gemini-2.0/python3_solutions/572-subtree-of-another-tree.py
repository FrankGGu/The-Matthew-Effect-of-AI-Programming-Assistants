class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def isSubtree(self, root: TreeNode, subRoot: TreeNode) -> bool:
        def isSameTree(p: TreeNode, q: TreeNode) -> bool:
            if not p and not q:
                return True
            if not p or not q:
                return False
            if p.val != q.val:
                return False
            return isSameTree(p.left, q.left) and isSameTree(p.right, q.right)

        def traverse(node: TreeNode, subRoot: TreeNode) -> bool:
            if not node:
                return False
            if isSameTree(node, subRoot):
                return True
            return traverse(node.left, subRoot) or traverse(node.right, subRoot)

        return traverse(root, subRoot)