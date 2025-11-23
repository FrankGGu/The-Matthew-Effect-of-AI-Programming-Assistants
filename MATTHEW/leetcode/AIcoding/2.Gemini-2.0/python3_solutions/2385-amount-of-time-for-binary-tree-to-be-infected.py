from collections import defaultdict, deque

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def amountOfTime(self, root: TreeNode, start: int) -> int:
        graph = defaultdict(list)

        def build_graph(node):
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
            node, time = q.popleft()
            max_time = max(max_time, time)

            for neighbor in graph[node]:
                if neighbor not in visited:
                    visited.add(neighbor)
                    q.append((neighbor, time + 1))

        return max_time