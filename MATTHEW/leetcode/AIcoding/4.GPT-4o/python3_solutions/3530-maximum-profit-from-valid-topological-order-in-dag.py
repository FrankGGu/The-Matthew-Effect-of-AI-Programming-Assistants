class Solution:
    def maximumProfit(self, n: int, edges: List[List[int]], prices: List[int]) -> int:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        in_degree = [0] * n

        for u, v in edges:
            graph[u].append(v)
            in_degree[v] += 1

        queue = deque()
        for i in range(n):
            if in_degree[i] == 0:
                queue.append(i)

        topo_order = []
        while queue:
            node = queue.popleft()
            topo_order.append(node)
            for neighbor in graph[node]:
                in_degree[neighbor] -= 1
                if in_degree[neighbor] == 0:
                    queue.append(neighbor)

        dp = [0] * n
        for node in topo_order:
            dp[node] += prices[node]
            for neighbor in graph[node]:
                dp[neighbor] = max(dp[neighbor], dp[node])

        return max(dp)