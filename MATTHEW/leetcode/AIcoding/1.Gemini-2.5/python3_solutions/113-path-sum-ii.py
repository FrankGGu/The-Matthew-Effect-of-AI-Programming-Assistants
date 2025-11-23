class Solution:
    def pathSum(self, root: Optional[TreeNode], targetSum: int) -> List[List[int]]:
        all_paths = []
        current_path = []

        def dfs(node, current_sum):
            if not node:
                return

            current_path.append(node.val)
            current_sum -= node.val

            if not node.left and not node.right and current_sum == 0:
                all_paths.append(list(current_path))

            dfs(node.left, current_sum)
            dfs(node.right, current_sum)

            current_path.pop()

        dfs(root, targetSum)
        return all_paths