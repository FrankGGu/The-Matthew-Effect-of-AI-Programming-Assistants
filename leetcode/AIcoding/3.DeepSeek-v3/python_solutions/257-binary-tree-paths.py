class Solution:
    def binaryTreePaths(self, root: Optional[TreeNode]) -> List[str]:
        if not root:
            return []
        res = []
        self.dfs(root, "", res)
        return res

    def dfs(self, node, path, res):
        if not node.left and not node.right:
            res.append(path + str(node.val))
            return
        if node.left:
            self.dfs(node.left, path + str(node.val) + "->", res)
        if node.right:
            self.dfs(node.right, path + str(node.val) + "->", res)