class Solution:
    def countValidPaths(self, root: TreeNode, k: int) -> int:
        def dfs(node, current_sum):
            if not node:
                return 0
            current_sum += node.val
            count = 1 if current_sum == k else 0
            count += dfs(node.left, current_sum)
            count += dfs(node.right, current_sum)
            return count

        def pathSum(node, current_sum):
            if not node:
                return 0
            count = dfs(node, 0)
            count += pathSum(node.left, current_sum)
            count += pathSum(node.right, current_sum)
            return count

        return pathSum(root, 0)