from collections import deque

class Solution:
    def largestPathValue(self, colors: str, edges: List[List[int]]) -> int:
        n = len(colors)
        adj = [[] for _ in range(n)]
        in_degree = [0] * n
        for u, v in edges:
            adj[u].append(v)
            in_degree[v] += 1

        q = deque()
        for i in range(n):
            if in_degree[i] == 0:
                q.append(i)

        cnt = [[0] * 26 for _ in range(n)]
        for i in range(n):
            cnt[i][ord(colors[i]) - ord('a')] += 1

        res = 0
        processed = 0
        while q:
            u = q.popleft()
            processed += 1
            res = max(res, max(cnt[u]))
            for v in adj[u]:
                for c in range(26):
                    cnt[v][c] = max(cnt[v][c], cnt[u][c] + (1 if ord(colors[v]) - ord('a') == c else 0))
                in_degree[v] -= 1
                if in_degree[v] == 0:
                    q.append(v)

        return res if processed == n else -1