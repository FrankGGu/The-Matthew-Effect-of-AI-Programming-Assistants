class Node:
    def __init__(self, val=None, neighbors=None):
        self.val = val
        self.neighbors = neighbors if neighbors is not None else []

class Solution:
    def cloneGraph(self, node: 'Node') -> 'Node':
        if not node:
            return None

        clone_map = {}

        def clone(n):
            if n in clone_map:
                return clone_map[n]
            clone_node = Node(n.val)
            clone_map[n] = clone_node
            for neighbor in n.neighbors:
                clone_node.neighbors.append(clone(neighbor))
            return clone_node

        return clone(node)