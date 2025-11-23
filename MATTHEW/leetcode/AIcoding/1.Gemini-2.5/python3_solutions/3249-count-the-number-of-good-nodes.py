class Solution:
    def goodNodes(self, root: TreeNode) -> int:
        if not root:
            return 0

        def dfs(node, max_val_so_far):
            if not node:
                return 0

            count = 0
            if node.val >= max_val_so_far:
                count = 1

            new_max_val = max(max_val_so_far, node.val)

            count += dfs(node.left, new_max_val)
            count += dfs(node.right, new_max_val)

            return count

        return dfs(root, float('-inf'))