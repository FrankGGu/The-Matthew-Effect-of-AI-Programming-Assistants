class Solution:
    def minimumTotalPrice(self, n: int, relations: List[List[int]], fees: List[int]) -> int:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        for u, v in relations:
            graph[u].append(v)
            graph[v].append(u)

        def bfs(start):
            visited = [False] * n
            queue = deque()
            queue.append((start, 0))
            visited[start] = True
            total = 0
            while queue:
                node, cost = queue.popleft()
                total += cost
                for neighbor in graph[node]:
                    if not visited[neighbor]:
                        visited[neighbor] = True
                        queue.append((neighbor, min(cost + fees[node], cost + fees[neighbor])))
            return total

        min_total = float('inf')
        for i in range(n):
            min_total = min(min_total, bfs(i))

        return min_total