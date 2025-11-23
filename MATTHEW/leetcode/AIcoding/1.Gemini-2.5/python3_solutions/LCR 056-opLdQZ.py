class Solution:
    def findTarget(self, root: Optional[TreeNode], k: int) -> bool:
        seen = set()

        def dfs(node):
            if not node:
                return False

            complement = k - node.val
            if complement in seen:
                return True

            seen.add(node.val)

            return dfs(node.left) or dfs(node.right)

        return dfs(root)