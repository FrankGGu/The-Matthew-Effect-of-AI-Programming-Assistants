class Codec:

    def serialize(self, root):
        res = []

        def dfs(node):
            if not node:
                res.append("#")
                return
            res.append(str(node.val))
            dfs(node.left)
            dfs(node.right)

        dfs(root)
        return ",".join(res)

    def deserialize(self, data):
        nodes = data.split(",")
        self.idx = 0

        def build_tree():
            if self.idx >= len(nodes):
                return None

            val = nodes[self.idx]
            self.idx += 1

            if val == "#":
                return None

            node = TreeNode(int(val))
            node.left = build_tree()
            node.right = build_tree()
            return node

        return build_tree()