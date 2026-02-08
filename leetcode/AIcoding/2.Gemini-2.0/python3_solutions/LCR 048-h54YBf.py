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
        self.data = data.split(",")
        self.i = 0
        return self.deserialize_helper()

    def deserialize_helper(self):
        if self.data[self.i] == "None":
            self.i += 1
            return None
        node = TreeNode(int(self.data[self.i]))
        self.i += 1
        node.left = self.deserialize_helper()
        node.right = self.deserialize_helper()
        return node