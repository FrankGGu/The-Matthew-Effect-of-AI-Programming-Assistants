class Solution:
    def goodNodes(self, root: TreeNode) -> int:
        def dfs(node, max_so_far):
            if not node:
                return 0

            count = 0
            if node.val >= max_so_far:
                count = 1

            new_max_so_far = max(max_so_far, node.val)

            count += dfs(node.left, new_max_so_far)
            count += dfs(node.right, new_max_so_far)

            return count

        return dfs(root, float('-inf'))