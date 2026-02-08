from collections import defaultdict, deque
from typing import Optional

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def amountOfTime(self, root: Optional[TreeNode], start: int) -> int:
        graph = defaultdict(list)

        def build_graph(node: Optional[TreeNode]):
            if not node:
                return

            if node.left:
                graph[node.val].append(node.left.val)
                graph[node.left.val].append(node.val)
                build_graph(node.left)
            if node.right:
                graph[node.val].append(node.right.val)
                graph[node.right.val].append(node.val)
                build_graph(node.right)

        build_graph(root)

        q = deque([(start, 0)])
        visited = {start}
        max_time = 0

        while q:
            current_node_val, current_time = q.popleft()
            max_time = max(max_time, current_time)

            for neighbor_val in graph[current_node_val]:
                if neighbor_val not in visited:
                    visited.add(neighbor_val)
                    q.append((neighbor_val, current_time + 1))

        return max_time