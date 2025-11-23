class Solution:
    def maximumScore(self, nums: List[int], edges: List[List[int]], start: int, end: int) -> int:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        def bfs(start, end):
            queue = deque([start])
            visited = {start}
            parent = {start: None}
            while queue:
                node = queue.popleft()
                if node == end:
                    break
                for neighbor in graph[node]:
                    if neighbor not in visited:
                        visited.add(neighbor)
                        parent[neighbor] = node
                        queue.append(neighbor)
            return parent

        parent = bfs(start, end)
        path = []
        if end not in parent:
            return 0
        while end is not None:
            path.append(end)
            end = parent[end]
        path.reverse()

        m = len(path)
        dp = [[0] * m for _ in range(m)]

        for length in range(1, m + 1):
            for i in range(m - length + 1):
                j = i + length - 1
                if length == 1:
                    dp[i][j] = nums[path[i]]
                else:
                    dp[i][j] = max(dp[i][j], dp[i][j - 1], dp[i + 1][j])

        return dp[0][m - 1]