class Solution:
    def smallestFromLeaf(self, root: TreeNode) -> str:
        self.result = None

        def dfs(node, path):
            if not node:
                return
            path.append(chr(ord('a') + node.val))
            if not node.left and not node.right:
                current = ''.join(reversed(path))
                if self.result is None or current < self.result:
                    self.result = current
            else:
                dfs(node.left, path)
                dfs(node.right, path)
            path.pop()

        dfs(root, [])
        return self.result