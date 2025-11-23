from collections import defaultdict, deque

class Solution:
    def largestPathValue(self, colors: str, edges: list[list[int]]) -> int:
        n = len(colors)
        adj = defaultdict(list)
        indegree = [0] * n
        for u, v in edges:
            adj[u].append(v)
            indegree[v] += 1

        q = deque()
        for i in range(n):
            if indegree[i] == 0:
                q.append(i)

        count = [[0] * 26 for _ in range(n)]
        for i in range(n):
            count[i][ord(colors[i]) - ord('a')] = 1

        visited = 0
        ans = 0
        while q:
            u = q.popleft()
            visited += 1
            ans = max(ans, max(count[u]))

            for v in adj[u]:
                for i in range(26):
                    count[v][i] = max(count[v][i], count[u][i] + (ord(colors[v]) - ord('a') == i))
                indegree[v] -= 1
                if indegree[v] == 0:
                    q.append(v)

        if visited != n:
            return -1
        return ans