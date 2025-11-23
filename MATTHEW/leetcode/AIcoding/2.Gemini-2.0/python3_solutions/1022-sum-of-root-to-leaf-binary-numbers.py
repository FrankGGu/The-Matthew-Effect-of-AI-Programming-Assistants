class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def sumRootToLeaf(self, root: TreeNode) -> int:
        def dfs(node, current_num):
            if not node:
                return 0

            current_num = (current_num << 1) | node.val

            if not node.left and not node.right:
                return current_num

            return dfs(node.left, current_num) + dfs(node.right, current_num)

        return dfs(root, 0) % (10**9 + 7)