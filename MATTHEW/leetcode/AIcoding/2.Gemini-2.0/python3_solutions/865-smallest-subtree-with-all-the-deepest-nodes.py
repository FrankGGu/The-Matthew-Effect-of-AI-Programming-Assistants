class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def subtreeWithAllDeepest(self, root: TreeNode) -> TreeNode:
        def depth(node):
            if not node:
                return 0
            return max(depth(node.left), depth(node.right)) + 1

        def helper(node):
            if not node:
                return None, 0

            left_subtree, left_depth = helper(node.left)
            right_subtree, right_depth = helper(node.right)

            if left_depth == right_depth:
                return node, left_depth + 1
            elif left_depth > right_depth:
                return left_subtree, left_depth + 1
            else:
                return right_subtree, right_depth + 1

        return helper(root)[0]