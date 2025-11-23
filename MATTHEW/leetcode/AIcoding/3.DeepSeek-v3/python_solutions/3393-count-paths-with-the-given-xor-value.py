class Solution:
    def countPaths(self, root: Optional[TreeNode], target: int) -> int:
        from collections import defaultdict

        self.result = 0
        prefix_counts = defaultdict(int)
        prefix_counts[0] = 1

        def dfs(node, current_xor):
            if not node:
                return

            current_xor ^= node.val
            self.result += prefix_counts.get(current_xor ^ target, 0)
            prefix_counts[current_xor] += 1

            dfs(node.left, current_xor)
            dfs(node.right, current_xor)

            prefix_counts[current_xor] -= 1

        dfs(root, 0)
        return self.result