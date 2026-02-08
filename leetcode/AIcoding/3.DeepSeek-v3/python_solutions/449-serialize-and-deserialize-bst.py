class Codec:

    def serialize(self, root: TreeNode) -> str:
        """Encodes a tree to a single string.
        """
        def postorder(node):
            return postorder(node.left) + postorder(node.right) + [node.val] if node else []
        return ' '.join(map(str, postorder(root)))

    def deserialize(self, data: str) -> TreeNode:
        """Decodes your encoded data to tree.
        """
        def helper(lower=float('-inf'), upper=float('inf')):
            if not data or data[-1] < lower or data[-1] > upper:
                return None
            val = data.pop()
            root = TreeNode(val)
            root.right = helper(val, upper)
            root.left = helper(lower, val)
            return root

        data = [int(x) for x in data.split() if x]
        return helper()