class Solution:
    def frogPosition(self, n: int, edges: List[List[int]], t: int, target: int) -> float:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        def bfs():
            queue = deque([(1, 1.0)])  # (node, probability)
            visited = {1}
            while queue:
                for _ in range(len(queue)):
                    node, prob = queue.popleft()
                    if node == target and t == 0:
                        return prob
                    if t > 0:
                        neighbors = [n for n in graph[node] if n not in visited]
                        if neighbors:
                            for neighbor in neighbors:
                                visited.add(neighbor)
                                queue.append((neighbor, prob / len(neighbors)))
                t -= 1
            return 0.0

        return bfs()