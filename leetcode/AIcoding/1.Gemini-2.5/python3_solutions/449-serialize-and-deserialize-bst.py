class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None

class Codec:

    def serialize(self, root: TreeNode) -> str:
        if not root:
            return ""

        res = []

        def preorder(node):
            if not node:
                return
            res.append(str(node.val))
            preorder(node.left)
            preorder(node.right)

        preorder(root)
        return ",".join(res)

    def deserialize(self, data: str) -> TreeNode:
        if not data:
            return None

        nodes_str = data.split(',')
        self.nodes = [int(x) for x in nodes_str]
        self.idx = 0

        def _deserialize_recursive(lower_bound, upper_bound):
            if self.idx == len(self.nodes):
                return None

            val = self.nodes[self.idx]

            if not (lower_bound < val < upper_bound):
                return None

            self.idx += 1
            root = TreeNode(val)
            root.left = _deserialize_recursive(lower_bound, val)
            root.right = _deserialize_recursive(val, upper_bound)
            return root

        return _deserialize_recursive(float('-inf'), float('inf'))