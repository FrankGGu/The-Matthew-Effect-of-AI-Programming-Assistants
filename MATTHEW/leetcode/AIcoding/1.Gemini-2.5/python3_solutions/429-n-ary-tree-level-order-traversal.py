"""
class Node:
    def __init__(self, val=None, children=None):
        self.val = val
        self.children = children
"""

from collections import deque

class Solution:
    def levelOrder(self, root: 'Node') -> list[list[int]]:
        if not root:
            return []

        result = []
        queue = deque([root])

        while queue:
            level_size = len(queue)
            current_level_nodes = []
            for _ in range(level_size):
                node = queue.popleft()
                current_level_nodes.append(node.val)
                if node.children:
                    for child in node.children:
                        queue.append(child)
            result.append(current_level_nodes)

        return result