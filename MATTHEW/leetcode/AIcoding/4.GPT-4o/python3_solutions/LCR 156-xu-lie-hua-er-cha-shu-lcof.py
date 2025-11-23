class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Codec:

    def serialize(self, root: TreeNode) -> str:
        def dfs(node):
            if not node:
                return "null,"
            return str(node.val) + "," + dfs(node.left) + dfs(node.right)

        return dfs(root)

    def deserialize(self, data: str) -> TreeNode:
        def dfs(values):
            value = next(values)
            if value == "null":
                return None
            node = TreeNode(int(value))
            node.left = dfs(values)
            node.right = dfs(values)
            return node

        return dfs(iter(data.split(',')))