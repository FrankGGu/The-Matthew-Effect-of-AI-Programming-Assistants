from typing import Optional, List

class Solution:
    def pathSum(self, root: Optional[TreeNode], targetSum: int) -> List[List[int]]:
        results = []
        current_path = []

        def dfs(node, current_sum):
            if not node:
                return

            current_path.append(node.val)
            current_sum += node.val

            if not node.left and not node.right:
                if current_sum == targetSum:
                    results.append(list(current_path))

            dfs(node.left, current_sum)
            dfs(node.right, current_sum)

            current_path.pop()

        dfs(root, 0)
        return results