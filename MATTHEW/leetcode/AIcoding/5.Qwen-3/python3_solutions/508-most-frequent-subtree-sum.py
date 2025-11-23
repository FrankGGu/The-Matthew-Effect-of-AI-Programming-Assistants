class Solution:
    def findFrequentTreeSum(self, root: TreeNode) -> List[int]:
        from collections import defaultdict

        def dfs(node):
            if not node:
                return 0
            total = node.val + dfs(node.left) + dfs(node.right)
            count[total] += 1
            return total

        count = defaultdict(int)
        dfs(root)
        max_freq = max(count.values()) if count else 0
        return [s for s in count if count[s] == max_freq]