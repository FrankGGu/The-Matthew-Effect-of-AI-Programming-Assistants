class Solution:
    def amountOfTime(self, root: Optional[TreeNode], start: int) -> int:
        from collections import defaultdict, deque

        graph = defaultdict(list)

        def build_graph(node, parent):
            if node:
                if parent:
                    graph[node.val].append(parent.val)
                    graph[parent.val].append(node.val)
                build_graph(node.left, node)
                build_graph(node.right, node)

        build_graph(root, None)

        queue = deque([start])
        visited = {start}
        time = -1

        while queue:
            for _ in range(len(queue)):
                curr = queue.popleft()
                for neighbor in graph[curr]:
                    if neighbor not in visited:
                        visited.add(neighbor)
                        queue.append(neighbor)
            time += 1

        return time