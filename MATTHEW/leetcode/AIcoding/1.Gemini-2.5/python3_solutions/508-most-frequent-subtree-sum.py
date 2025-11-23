import collections

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def findFrequentTreeSum(self, root: TreeNode) -> list[int]:
        if not root:
            return []

        sum_counts = collections.Counter()

        def dfs(node):
            if not node:
                return 0

            left_sum = dfs(node.left)
            right_sum = dfs(node.right)

            current_subtree_sum = node.val + left_sum + right_sum
            sum_counts[current_subtree_sum] += 1
            return current_subtree_sum

        dfs(root)

        if not sum_counts:
            return []

        max_freq = 0
        for freq in sum_counts.values():
            max_freq = max(max_freq, freq)

        result = []
        for s, freq in sum_counts.items():
            if freq == max_freq:
                result.append(s)

        return result