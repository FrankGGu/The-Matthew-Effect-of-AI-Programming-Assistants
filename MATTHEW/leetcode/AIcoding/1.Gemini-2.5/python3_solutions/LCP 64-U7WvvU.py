class Solution:
    def minCameraCover(self, root: Optional[TreeNode]) -> int:
        self.cameras = 0

        def dfs(node):
            if not node:
                return 1

            left_state = dfs(node.left)
            right_state = dfs(node.right)

            if left_state == 0 or right_state == 0:
                self.cameras += 1
                return 2

            if left_state == 2 or right_state == 2:
                return 1

            return 0

        if dfs(root) == 0:
            self.cameras += 1

        return self.cameras