class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def lcaDeepestLeaves(self, root: TreeNode) -> TreeNode:
        def depth(node):
            if not node:
                return 0
            return 1 + max(depth(node.left), depth(node.right))

        def lca(node):
            if not node:
                return None, 0

            left, l_depth = lca(node.left)
            right, r_depth = lca(node.right)

            if l_depth == r_depth:
                return node, l_depth + 1
            elif l_depth > r_depth:
                return left, l_depth + 1
            else:
                return right, r_depth + 1

        return lca(root)[0]