from collections import defaultdict, deque
from typing import List

class Solution:
    def distanceK(self, root: TreeNode, target: TreeNode, k: int) -> List[int]:
        graph = defaultdict(list)

        def build_graph(node, parent):
            if not node:
                return
            if parent:
                graph[node.val].append(parent.val)
                graph[parent.val].append(node.val)
            build_graph(node.left, node)
            build_graph(node.right, node)

        build_graph(root, None)

        queue = deque()
        queue.append((target.val, 0))
        visited = set()
        visited.add(target.val)
        result = []

        while queue:
            node_val, dist = queue.popleft()
            if dist == k:
                result.append(node_val)
                continue
            for neighbor in graph[node_val]:
                if neighbor not in visited:
                    visited.add(neighbor)
                    queue.append((neighbor, dist + 1))

        return result