class Solution:
    def amountOfTime(self, root: Optional[TreeNode], start: int) -> int:
        from collections import defaultdict, deque

        def build_graph(node, parent):
            if not node:
                return
            if parent:
                graph[node.val].append(parent.val)
                graph[parent.val].append(node.val)
            build_graph(node.left, node)
            build_graph(node.right, node)

        graph = defaultdict(list)
        build_graph(root, None)

        visited = set()
        queue = deque()
        queue.append((start, 0))
        visited.add(start)

        max_time = 0

        while queue:
            node_val, time = queue.popleft()
            max_time = max(max_time, time)
            for neighbor in graph[node_val]:
                if neighbor not in visited:
                    visited.add(neighbor)
                    queue.append((neighbor, time + 1))

        return max_time