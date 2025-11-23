class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def sumEvenGrandparent(self, root: TreeNode) -> int:
        def dfs(node, parent_val, grandparent_val):
            if not node:
                return 0

            current_sum = 0
            if grandparent_val % 2 == 0:
                current_sum += node.val

            current_sum += dfs(node.left, node.val, parent_val)
            current_sum += dfs(node.right, node.val, parent_val)

            return current_sum

        return dfs(root, 1, 1)