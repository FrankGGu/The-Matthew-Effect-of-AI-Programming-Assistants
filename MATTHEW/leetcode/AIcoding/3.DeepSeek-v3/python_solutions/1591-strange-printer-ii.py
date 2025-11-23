class Solution:
    def isPrintable(self, targetGrid: List[List[int]]) -> bool:
        from collections import defaultdict, deque

        m, n = len(targetGrid), len(targetGrid[0])
        color_positions = defaultdict(lambda: [m, n, -1, -1])  # min_i, min_j, max_i, max_j

        for i in range(m):
            for j in range(n):
                color = targetGrid[i][j]
                color_positions[color][0] = min(color_positions[color][0], i)
                color_positions[color][1] = min(color_positions[color][1], j)
                color_positions[color][2] = max(color_positions[color][2], i)
                color_positions[color][3] = max(color_positions[color][3], j)

        graph = defaultdict(set)
        in_degree = defaultdict(int)
        colors = set(color_positions.keys())

        for color in colors:
            min_i, min_j, max_i, max_j = color_positions[color]
            for i in range(min_i, max_i + 1):
                for j in range(min_j, max_j + 1):
                    c = targetGrid[i][j]
                    if c != color:
                        if c not in graph[color]:
                            graph[color].add(c)
                            in_degree[c] += 1

        queue = deque([color for color in colors if in_degree[color] == 0])
        processed = 0

        while queue:
            current = queue.popleft()
            processed += 1
            for neighbor in graph[current]:
                in_degree[neighbor] -= 1
                if in_degree[neighbor] == 0:
                    queue.append(neighbor)

        return processed == len(colors)