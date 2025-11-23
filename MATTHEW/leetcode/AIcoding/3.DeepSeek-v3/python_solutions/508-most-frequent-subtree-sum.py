class Solution:
    def findFrequentTreeSum(self, root: Optional[TreeNode]) -> List[int]:
        from collections import defaultdict

        if not root:
            return []

        freq = defaultdict(int)
        max_freq = 0

        def subtreeSum(node):
            nonlocal max_freq
            if not node:
                return 0
            left_sum = subtreeSum(node.left)
            right_sum = subtreeSum(node.right)
            total = node.val + left_sum + right_sum
            freq[total] += 1
            if freq[total] > max_freq:
                max_freq = freq[total]
            return total

        subtreeSum(root)

        return [key for key, val in freq.items() if val == max_freq]