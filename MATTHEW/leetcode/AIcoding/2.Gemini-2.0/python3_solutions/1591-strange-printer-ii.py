from collections import defaultdict

class Solution:
    def isPrintable(self, targetGrid: list[list[int]]) -> bool:
        m, n = len(targetGrid), len(targetGrid[0])
        color_ranges = defaultdict(lambda: [float('inf'), float('inf'), float('-inf'), float('-inf')])
        for r in range(m):
            for c in range(n):
                color = targetGrid[r][c]
                color_ranges[color][0] = min(color_ranges[color][0], r)
                color_ranges[color][1] = min(color_ranges[color][1], c)
                color_ranges[color][2] = max(color_ranges[color][2], r)
                color_ranges[color][3] = max(color_ranges[color][3], c)

        graph = defaultdict(set)
        for color1 in color_ranges:
            for color2 in color_ranges:
                if color1 == color2:
                    continue
                r1_min, c1_min, r1_max, c1_max = color_ranges[color1]
                r2_min, c2_min, r2_max, c2_max = color_ranges[color2]

                for r in range(r2_min, r2_max + 1):
                    for c in range(c2_min, c2_max + 1):
                        if r1_min <= r <= r1_max and c1_min <= c <= c1_max and targetGrid[r][c] == color1:
                            graph[color1].add(color2)
                            break
                    else:
                        continue
                    break

        visited = set()
        recursion_stack = set()

        def has_cycle(node):
            if node in recursion_stack:
                return True
            if node in visited:
                return False

            visited.add(node)
            recursion_stack.add(node)

            for neighbor in graph[node]:
                if has_cycle(neighbor):
                    return True

            recursion_stack.remove(node)
            return False

        for color in color_ranges:
            if has_cycle(color):
                return False

        return True