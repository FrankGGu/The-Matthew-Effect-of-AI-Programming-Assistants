class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None

class Codec:

    def serialize(self, root):
        if not root:
            return "None,"
        return str(root.val) + "," + self.serialize(root.left) + self.serialize(root.right)

    def deserialize(self, data):
        def deserialize_helper(nodes):
            val = next(nodes)
            if val == "None":
                return None
            node = TreeNode(int(val))
            node.left = deserialize_helper(nodes)
            node.right = deserialize_helper(nodes)
            return node

        nodes = iter(data.split(","))
        return deserialize_helper(nodes)