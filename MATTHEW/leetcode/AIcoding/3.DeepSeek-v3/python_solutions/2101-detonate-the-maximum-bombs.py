class Solution:
    def maximumDetonation(self, bombs: List[List[int]]) -> int:
        n = len(bombs)
        graph = [[] for _ in range(n)]

        for i in range(n):
            x1, y1, r1 = bombs[i]
            for j in range(n):
                if i == j:
                    continue
                x2, y2, _ = bombs[j]
                distance_sq = (x1 - x2) ** 2 + (y1 - y2) ** 2
                if distance_sq <= r1 ** 2:
                    graph[i].append(j)

        max_detonations = 0

        for i in range(n):
            visited = [False] * n
            queue = deque()
            queue.append(i)
            visited[i] = True
            count = 1

            while queue:
                current = queue.popleft()
                for neighbor in graph[current]:
                    if not visited[neighbor]:
                        visited[neighbor] = True
                        queue.append(neighbor)
                        count += 1

            max_detonations = max(max_detonations, count)

        return max_detonations