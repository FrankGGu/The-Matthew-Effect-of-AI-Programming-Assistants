import collections

class Solution:
    def isPrintable(self, targetGrid: list[list[int]]) -> bool:
        m, n = len(targetGrid), len(targetGrid[0])

        min_r = [m] * 61
        max_r = [-1] * 61
        min_c = [n] * 61
        max_c = [-1] * 61

        colors_present = set()

        for r in range(m):
            for c in range(n):
                color = targetGrid[r][c]
                colors_present.add(color)
                min_r[color] = min(min_r[color], r)
                max_r[color] = max(max_r[color], r)
                min_c[color] = min(min_c[color], c)
                max_c[color] = max(max_c[color], c)

        adj = collections.defaultdict(list)
        in_degree = collections.defaultdict(int)

        unique_edges = set()

        for color_c in colors_present:
            for r in range(min_r[color_c], max_r[color_c] + 1):
                for c in range(min_c[color_c], max_c[color_c] + 1):
                    actual_color = targetGrid[r][c]
                    if actual_color != color_c:
                        if (color_c, actual_color) not in unique_edges:
                            adj[color_c].append(actual_color)
                            in_degree[actual_color] += 1
                            unique_edges.add((color_c, actual_color))

        q = collections.deque()

        for color_c in colors_present:
            if in_degree[color_c] == 0:
                q.append(color_c)

        printed_count = 0
        while q:
            u = q.popleft()
            printed_count += 1

            for v in adj[u]:
                in_degree[v] -= 1
                if in_degree[v] == 0:
                    q.append(v)

        return printed_count == len(colors_present)