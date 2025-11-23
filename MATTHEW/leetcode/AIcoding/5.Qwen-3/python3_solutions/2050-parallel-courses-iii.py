from collections import deque, defaultdict
from typing import List

class Solution:
    def minimumTime(self, n: int, relations: List[List[int]]) L) -> int:
        graph = defaultdict(list)
        in_degree = [0] * n
        for u, v in relations:
            graph[u - 1].append(v - 1)
            in_degree[v - 1] += 1

        queue = deque()
        time = [0] * n
        for i in range(n):
            if in_degree[i] == 0:
                queue.append(i)

        while queue:
            node = queue.popleft()
            for neighbor in graph[node]:
                in_degree[neighbor] -= 1
                time[neighbor] = max(time[neighbor], time[node] + 1)
                if in_degree[neighbor] == 0:
                    queue.append(neighbor)

        return max(time)