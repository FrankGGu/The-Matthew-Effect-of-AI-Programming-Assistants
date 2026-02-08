class Solution:
    def pathSum(self, root: Optional[TreeNode], targetSum: int) -> List[List[int]]:
        def dfs(node, current_sum, path, result):
            if not node:
                return
            current_sum += node.val
            path.append(node.val)
            if not node.left and not node.right and current_sum == targetSum:
                result.append(list(path))
            dfs(node.left, current_sum, path, result)
            dfs(node.right, current_sum, path, result)
            path.pop()

        result = []
        dfs(root, 0, [], result)
        return result