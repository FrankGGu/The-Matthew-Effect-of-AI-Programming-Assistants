class Solution:
    def domino(self, n: int, m: int, broken: list[list[int]]) -> int:
        if n * m % 2 != 0:
            return 0

        broken_set = set()
        for r, c in broken:
            broken_set.add((r, c))

        def is_valid(r, c):
            return 0 <= r < n and 0 <= c < m and (r, c) not in broken_set

        graph = {}
        for r in range(n):
            for c in range(m):
                if (r + c) % 2 == 0 and is_valid(r, c):
                    graph[(r, c)] = []
                    if is_valid(r + 1, c):
                        graph[(r, c)].append((r + 1, c))
                    if is_valid(r - 1, c):
                        graph[(r, c)].append((r - 1, c))
                    if is_valid(r, c + 1):
                        graph[(r, c)].append((r, c + 1))
                    if is_valid(r, c - 1):
                        graph[(r, c)].append((r, c - 1))

        matching = {}

        def dfs(node, visited):
            visited.add(node)
            for neighbor in graph[node]:
                if neighbor not in matching or matching[neighbor] not in visited and dfs(matching[neighbor], visited):
                    matching[neighbor] = node
                    return True
            return False

        count = 0
        for r in range(n):
            for c in range(m):
                if (r + c) % 2 == 0 and is_valid(r, c):
                    visited = set()
                    if dfs((r, c), visited):
                        count += 1

        return count