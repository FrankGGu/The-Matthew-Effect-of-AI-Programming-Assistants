class Solution:
    def binaryTreePaths(self, root: Optional[TreeNode]) -> List[str]:
        paths = []

        def dfs(node, current_path_str):
            if not node:
                return

            if not current_path_str:
                current_path_str = str(node.val)
            else:
                current_path_str += "->" + str(node.val)

            if not node.left and not node.right:
                paths.append(current_path_str)
                return

            dfs(node.left, current_path_str)
            dfs(node.right, current_path_str)

        dfs(root, "")
        return paths