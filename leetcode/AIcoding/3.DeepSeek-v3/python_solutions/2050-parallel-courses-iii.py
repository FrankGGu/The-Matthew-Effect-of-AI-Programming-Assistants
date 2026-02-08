import heapq
from collections import deque

class Solution:
    def minimumTime(self, n: int, relations: List[List[int]], time: List[int]) -> int:
        graph = [[] for _ in range(n)]
        in_degree = [0] * n
        for prev, next_course in relations:
            graph[prev - 1].append(next_course - 1)
            in_degree[next_course - 1] += 1

        queue = deque()
        max_time = [0] * n
        for i in range(n):
            if in_degree[i] == 0:
                queue.append(i)
                max_time[i] = time[i]

        while queue:
            current = queue.popleft()
            for neighbor in graph[current]:
                if max_time[neighbor] < max_time[current] + time[neighbor]:
                    max_time[neighbor] = max_time[current] + time[neighbor]
                in_degree[neighbor] -= 1
                if in_degree[neighbor] == 0:
                    queue.append(neighbor)

        return max(max_time)