class Solution:
    def colorTree(self, root: Optional[TreeNode]) -> List[int]:
        if not root:
            return []

        color = {}
        def dfs(node, c):
            if not node:
                return
            color[node.val] = c
            dfs(node.left, 1 - c)
            dfs(node.right, 1 - c)

        dfs(root, 0)
        return [color[node.val] for node in self.inOrder(root)]

    def inOrder(self, root):
        return [] if not root else self.inOrder(root.left) + [root] + self.inOrder(root.right)