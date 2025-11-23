from typing import List
import collections

class Solution:
    def isReachable(self, targetGrid: List[List[int]]) -> bool:
        color_positions = collections.defaultdict(list)
        for i in range(len(targetGrid)):
            for j in range(len(targetGrid[0])):
                color_positions[targetGrid[i][j]].append((i, j))

        colors = list(color_positions.keys())
        color_order = {}
        for c in colors:
            color_order[c] = 0

        for c in colors:
            for (x1, y1) in color_positions[c]:
                for (x2, y2) in color_positions[c]:
                    if x1 != x2 and y1 != y2:
                        for d in colors:
                            if d != c:
                                for (x3, y3) in color_positions[d]:
                                    if (x3 == x1 or x3 == x2) and (y3 == y1 or y3 == y2):
                                        color_order[d] += 1

        in_degree = {c: 0 for c in colors}
        for c in colors:
            for d in colors:
                if color_order[d] > 0 and d != c:
                    in_degree[c] += 1

        queue = collections.deque()
        for c in colors:
            if in_degree[c] == 0:
                queue.append(c)

        count = 0
        while queue:
            c = queue.popleft()
            count += 1
            for d in colors:
                if color_order[d] > 0 and d != c:
                    in_degree[d] -= 1
                    if in_degree[d] == 0:
                        queue.append(d)

        return count == len(colors)