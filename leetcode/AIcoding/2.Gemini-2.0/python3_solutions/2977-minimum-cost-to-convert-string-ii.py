class Solution:
    def minimumCost(self, source: str, target: str, original: list[str], changed: list[str], cost: list[int]) -> int:
        n = len(source)
        m = len(target)

        adj = {}
        for i in range(len(original)):
            o = original[i]
            c = changed[i]
            w = cost[i]
            if o not in adj:
                adj[o] = {}
            adj[o][c] = w

        dist = {}
        for start in adj:
            dist[start] = {start: 0}
            q = [start]
            visited = {start}

            while q:
                u = q.pop(0)
                for v in adj[u]:
                    if v not in dist[start] or dist[start][u] + adj[u][v] < dist[start].get(v, float('inf')):
                        dist[start][v] = dist[start][u] + adj[u][v]
                        if v not in visited:
                            q.append(v)
                            visited.add(v)

        dp = [float('inf')] * (n + 1)
        dp[0] = 0

        for i in range(1, n + 1):
            dp[i] = dp[i-1] + ord(source[i-1]) - ord(target[i-1]) if source[i-1] != target[i-1] else dp[i-1]
            if source[i-1] == target[i-1]:
                dp[i] = dp[i-1]

            for j in range(i):
                sub_s = source[j:i]
                sub_t = target[j:i]

                if sub_s in dist and sub_t in dist[sub_s]:
                    dp[i] = min(dp[i], dp[j] + dist[sub_s][sub_t])
                elif sub_s == sub_t:
                    dp[i] = min(dp[i], dp[j])

        return dp[n] if dp[n] != float('inf') else -1