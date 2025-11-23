import collections

class Codec:

    def serialize(self, root):
        """Encodes a tree to a single string.

        :type root: TreeNode
        :rtype: str
        """
        res = []

        def dfs(node):
            if not node:
                res.append("null")
                return
            res.append(str(node.val))
            dfs(node.left)
            dfs(node.right)

        dfs(root)
        return ",".join(res)

    def deserialize(self, data):
        """Decodes your encoded data to tree.

        :type data: str
        :rtype: TreeNode
        """
        nodes = collections.deque(data.split(','))

        def dfs():
            if not nodes:
                return None

            val_str = nodes.popleft()
            if val_str == "null":
                return None

            node = TreeNode(int(val_str))
            node.left = dfs()
            node.right = dfs()
            return node

        return dfs()