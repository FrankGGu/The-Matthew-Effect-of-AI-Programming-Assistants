class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def countPairs(self, root: TreeNode, distance: int) -> int:
        def dfs(node):
            if not node:
                return [0] * (distance + 1)
            if not node.left and not node.right:
                return [1] + [0] * distance

            left_counts = dfs(node.left)
            right_counts = dfs(node.right)
            for i in range(distance):
                for j in range(distance):
                    if i + j + 2 <= distance:
                        self.result += left_counts[i] * right_counts[j]
            counts = [0] * (distance + 1)
            for i in range(distance):
                if i + 1 <= distance:
                    counts[i + 1] += left_counts[i]
                    counts[i + 1] += right_counts[i]
            return counts

        self.result = 0
        dfs(root)
        return self.result