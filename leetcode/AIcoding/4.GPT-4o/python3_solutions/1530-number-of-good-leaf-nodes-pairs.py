class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def countPairs(self, root: TreeNode, distance: int) -> int:
        def dfs(node):
            if not node:
                return []
            if not node.left and not node.right:
                return [1]
            left_distances = dfs(node.left)
            right_distances = dfs(node.right)
            for d1 in left_distances:
                for d2 in right_distances:
                    if d1 + d2 <= distance:
                        self.count += 1
            return [d + 1 for d in left_distances + right_distances]

        self.count = 0
        dfs(root)
        return self.count