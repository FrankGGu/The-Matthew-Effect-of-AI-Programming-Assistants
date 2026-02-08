from collections import defaultdict
class Solution:
    def findFrequentTreeSum(self, root: TreeNode) -> List[int]:
        def dfs(node):
            if not node:
                return 0
            total = node.val + dfs(node.left) + dfs(node.right)
            count[total] += 1
            return total

        count = defaultdict(int)
        dfs(root)
        max_freq = max(count.values())
        return [s for s, freq in count.items() if freq == max_freq]