from collections import defaultdict, deque

class Solution:
    def numOfMinutes(self, n: int, headID: int, manager: List[int], informTime: List[int]) -> int:
        graph = defaultdict(list)
        for i in range(n):
            if manager[i] != -1:
                graph[manager[i]].append(i)

        queue = deque()
        queue.append((headID, 0))
        max_time = 0

        while queue:
            current, time = queue.popleft()
            max_time = max(max_time, time)
            for employee in graph[current]:
                queue.append((employee, time + informTime[current]))

        return max_time