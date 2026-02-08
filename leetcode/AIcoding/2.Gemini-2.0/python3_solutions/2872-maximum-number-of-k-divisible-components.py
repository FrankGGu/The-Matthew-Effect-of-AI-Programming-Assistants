class Solution:
    def maxKDivisibleComponents(self, n: int, edges: list[list[int]], values: list[int], k: int) -> int:
        graph = [[] for _ in range(n)]
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        visited = [False] * n
        ans = 0

        def dfs(node):
            visited[node] = True
            total_sum = values[node]
            count = 1
            for neighbor in graph[node]:
                if not visited[neighbor]:
                    s, c = dfs(neighbor)
                    total_sum += s
                    count += c
            return total_sum, count

        for i in range(n):
            if not visited[i]:
                total_sum, count = dfs(i)
                if total_sum % k == 0:
                    ans += 1

        return ans