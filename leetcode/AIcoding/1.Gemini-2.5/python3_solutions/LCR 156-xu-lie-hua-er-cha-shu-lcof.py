class TreeNode(object):
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None

class Codec:

    def serialize(self, root):
        """Encodes a tree to a single string.

        :type root: TreeNode
        :rtype: str
        """
        if not root:
            return "None"

        queue = [root]
        result = []

        while queue:
            node = queue.pop(0)
            if node:
                result.append(str(node.val))
                queue.append(node.left)
                queue.append(node.right)
            else:
                result.append("None")

        # Remove trailing "None"s to make it more compact
        while result and result[-1] == "None":
            result.pop()

        return ",".join(result)

    def deserialize(self, data):
        """Decodes your encoded data to tree.

        :type data: str
        :rtype: TreeNode
        """
        if data == "None":
            return None

        nodes_str = data.split(',')
        if not nodes_str:
            return None

        root_val = nodes_str[0]
        root = TreeNode(int(root_val))

        queue = [root]
        i = 1

        while queue and i < len(nodes_str):
            current_node = queue.pop(0)

            # Left child
            if i < len(nodes_str):
                left_val = nodes_str[i]
                if left_val != "None":
                    current_node.left = TreeNode(int(left_val))
                    queue.append(current_node.left)
                i += 1

            # Right child
            if i < len(nodes_str):
                right_val = nodes_str[i]
                if right_val != "None":
                    current_node.right = TreeNode(int(right_val))
                    queue.append(current_node.right)
                i += 1

        return root