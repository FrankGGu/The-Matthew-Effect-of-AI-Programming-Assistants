from collections import defaultdict

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def findFrequentTreeSum(self, root: TreeNode) -> list[int]:
        sums = defaultdict(int)

        def subtree_sum(node):
            if not node:
                return 0
            left_sum = subtree_sum(node.left)
            right_sum = subtree_sum(node.right)
            total_sum = node.val + left_sum + right_sum
            sums[total_sum] += 1
            return total_sum

        subtree_sum(root)

        max_freq = 0
        for freq in sums.values():
            max_freq = max(max_freq, freq)

        result = []
        for sum_val, freq in sums.items():
            if freq == max_freq:
                result.append(sum_val)

        return result