class Node:
    def __init__(self, val=None, children=None):
        self.val = val
        self.children = children

class Solution:
    def levelOrder(self, root: 'Node') -> list[list[int]]:
        if not root:
            return []

        result = []
        queue = [root]

        while queue:
            level_values = []
            level_size = len(queue)

            for _ in range(level_size):
                node = queue.pop(0)
                level_values.append(node.val)

                if node.children:
                    queue.extend(node.children)

            result.append(level_values)

        return result