from collections import defaultdict

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def pathSum(self, root: TreeNode, targetSum: int) -> int:
        self.count = 0

        # prefix_sum_counts stores the frequency of each prefix sum encountered
        # along the path from the root to the current node.
        # Initialize with {0: 1} to handle paths that start from the root
        # and sum exactly to targetSum.
        prefix_sum_counts = defaultdict(int)
        prefix_sum_counts[0] = 1

        def dfs(node, current_sum):
            if not node:
                return

            current_sum += node.val

            self.count += prefix_sum_counts[current_sum - targetSum]

            prefix_sum_counts[current_sum] += 1

            dfs(node.left, current_sum)
            dfs(node.right, current_sum)

            prefix_sum_counts[current_sum] -= 1

        dfs(root, 0)
        return self.count