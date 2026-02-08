class Solution:
    def numOfMinutes(self, n: int, headID: int, manager: List[int], informTime: List[int]) -> int:
        adj = [[] for _ in range(n)]
        for i in range(n):
            if manager[i] != -1:
                adj[manager[i]].append(i)

        def dfs(node):
            max_time = 0
            for neighbor in adj[node]:
                max_time = max(max_time, dfs(neighbor))
            return max_time + informTime[node]

        return dfs(headID)