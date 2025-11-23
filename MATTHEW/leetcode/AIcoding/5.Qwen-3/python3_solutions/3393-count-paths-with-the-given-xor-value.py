class Solution:
    def countPaths(self, root: Optional[TreeNode], target: int) -> int:
        from collections import defaultdict

        prefix_counts = defaultdict(int)
        prefix_counts[0] = 1

        def dfs(node, current_xor):
            if not node:
                return 0
            current_xor ^= node.val
            count = prefix_counts[current_xor ^ target]
            prefix_counts[current_xor] += 1
            count += dfs(node.left, current_xor)
            count += dfs(node.right, current_xor)
            prefix_counts[current_xor] -= 1
            return count

        return dfs(root, 0)