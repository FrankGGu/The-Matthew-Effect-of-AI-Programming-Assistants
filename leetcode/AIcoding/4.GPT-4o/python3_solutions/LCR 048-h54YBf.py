import collections

class Codec:

    def serialize(self, root: TreeNode) -> str:
        if not root:
            return ''
        result = []
        queue = collections.deque([root])
        while queue:
            node = queue.popleft()
            if node:
                result.append(str(node.val))
                queue.append(node.left)
                queue.append(node.right)
            else:
                result.append('null')
        return ','.join(result)

    def deserialize(self, data: str) -> TreeNode:
        if not data:
            return None
        nodes = data.split(',')
        root = TreeNode(int(nodes[0]))
        queue = collections.deque([root])
        index = 1
        while queue:
            node = queue.popleft()
            if nodes[index] != 'null':
                node.left = TreeNode(int(nodes[index]))
                queue.append(node.left)
            index += 1
            if index < len(nodes) and nodes[index] != 'null':
                node.right = TreeNode(int(nodes[index]))
                queue.append(node.right)
            index += 1
        return root