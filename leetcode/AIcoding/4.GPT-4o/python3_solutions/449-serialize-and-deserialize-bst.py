class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Codec:

    def serialize(self, root: TreeNode) -> str:
        def dfs(node):
            if not node:
                return "None,"
            return str(node.val) + "," + dfs(node.left) + dfs(node.right)
        return dfs(root)

    def deserialize(self, data: str) -> TreeNode:
        def dfs(vals):
            if vals[0] == "None":
                vals.pop(0)
                return None
            node = TreeNode(int(vals[0]))
            vals.pop(0)
            node.left = dfs(vals)
            node.right = dfs(vals)
            return node

        return dfs(data.split(",")[:-1])