class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def findSecondMinimumValue(self, root: TreeNode) -> int:
        if not root:
            return -1

        first_min = root.val
        second_min = float('inf')

        def dfs(node):
            nonlocal second_min
            if not node:
                return

            if node.val > first_min and node.val < second_min:
                second_min = node.val
            elif node.val == first_min:
                dfs(node.left)
                dfs(node.right)

        dfs(root)

        return second_min if second_min != float('inf') else -1