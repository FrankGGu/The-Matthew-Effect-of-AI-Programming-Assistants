class Codec:

    def serialize(self, root):
        if not root:
            return ""
        nodes = []
        def preorder(node):
            if node:
                nodes.append(str(node.val))
                preorder(node.left)
                preorder(node.right)
        preorder(root)
        return ",".join(nodes)

    def deserialize(self, data):
        if not data:
            return None
        nodes = [int(x) for x in data.split(",")]

        def construct(nodes):
            if not nodes:
                return None
            root_val = nodes[0]
            root = TreeNode(root_val)

            i = 1
            while i < len(nodes) and nodes[i] < root_val:
                i += 1

            root.left = construct(nodes[1:i])
            root.right = construct(nodes[i:])

            return root

        return construct(nodes)