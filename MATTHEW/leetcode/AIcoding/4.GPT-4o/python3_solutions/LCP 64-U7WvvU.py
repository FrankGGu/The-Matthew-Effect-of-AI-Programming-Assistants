class Solution:
    def minCameraCover(self, root: Optional[TreeNode]) -> int:
        def dfs(node):
            if not node:
                return 0, 0, float('inf')
            left, left_with_camera, left_without_camera = dfs(node.left)
            right, right_with_camera, right_without_camera = dfs(node.right)
            with_camera = 1 + left_without_camera + right_without_camera
            without_camera = left_with_camera + right_with_camera
            return with_camera, without_camera, min(with_camera, left_with_camera + right_with_camera)

        cameras, _, _ = dfs(root)
        return cameras