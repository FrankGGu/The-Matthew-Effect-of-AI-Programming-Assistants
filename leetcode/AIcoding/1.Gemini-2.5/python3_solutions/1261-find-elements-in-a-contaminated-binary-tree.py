class FindElements:

    def __init__(self, root: Optional[TreeNode]):
        self.recovered_values = set()

        def dfs(node, val):
            if not node:
                return

            self.recovered_values.add(val)
            dfs(node.left, 2 * val + 1)
            dfs(node.right, 2 * val + 2)

        dfs(root, 0)

    def find(self, target: int) -> bool:
        return target in self.recovered_values