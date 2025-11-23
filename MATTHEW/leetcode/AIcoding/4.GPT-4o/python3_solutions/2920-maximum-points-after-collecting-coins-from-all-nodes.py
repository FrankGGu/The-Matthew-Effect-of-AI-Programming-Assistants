class Solution:
    def maxPoints(self, points: List[List[int]]) -> int:
        from collections import defaultdict

        graph = defaultdict(list)
        n = len(points)

        for i in range(n):
            for j in range(n):
                if i != j:
                    distance = abs(points[i][0] - points[j][0]) + abs(points[i][1] - points[j][1])
                    if distance <= 2:
                        graph[i].append(j)

        dp = [-1] * n

        def dfs(node):
            if dp[node] != -1:
                return dp[node]
            max_points = points[node][2]
            for neighbor in graph[node]:
                max_points = max(max_points, points[node][2] + dfs(neighbor))
            dp[node] = max_points
            return max_points

        max_total = 0
        for i in range(n):
            max_total = max(max_total, dfs(i))

        return max_total