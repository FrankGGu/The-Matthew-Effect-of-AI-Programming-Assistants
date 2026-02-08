class Solution:
    def smallestFromLeaf(self, root: Optional[TreeNode]) -> str:
        self.result = "~"

        def dfs(node, path):
            if not node:
                return
            path.append(chr(node.val + ord('a')))
            if not node.left and not node.right:
                current_str = ''.join(reversed(path))
                if current_str < self.result:
                    self.result = current_str
            dfs(node.left, path)
            dfs(node.right, path)
            path.pop()

        dfs(root, [])
        return self.result