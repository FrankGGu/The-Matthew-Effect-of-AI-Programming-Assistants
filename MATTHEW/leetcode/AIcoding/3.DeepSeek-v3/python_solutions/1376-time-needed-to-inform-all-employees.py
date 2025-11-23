class Solution:
    def numOfMinutes(self, n: int, headID: int, manager: List[int], informTime: List[int]) -> int:
        from collections import defaultdict

        graph = defaultdict(list)
        for i in range(n):
            if manager[i] != -1:
                graph[manager[i]].append(i)

        stack = [(headID, 0)]
        res = 0

        while stack:
            node, time = stack.pop()
            res = max(res, time)
            for neighbor in graph[node]:
                stack.append((neighbor, time + informTime[node]))

        return res