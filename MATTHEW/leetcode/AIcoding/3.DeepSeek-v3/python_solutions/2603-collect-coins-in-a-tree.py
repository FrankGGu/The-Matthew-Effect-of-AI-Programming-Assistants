class Solution:
    def collectTheCoins(self, coins: List[int], edges: List[List[int]]) -> int:
        n = len(coins)
        adj = [[] for _ in range(n)]
        degree = [0] * n
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)
            degree[u] += 1
            degree[v] += 1

        # Step 1: Remove leaves without coins
        q = deque()
        for i in range(n):
            if degree[i] == 1 and coins[i] == 0:
                q.append(i)

        while q:
            u = q.popleft()
            for v in adj[u]:
                if degree[v] > 0:
                    degree[v] -= 1
                    if degree[v] == 1 and coins[v] == 0:
                        q.append(v)
            degree[u] = 0

        # Step 2: Trim leaves two times
        for _ in range(2):
            q = deque()
            for i in range(n):
                if degree[i] == 1:
                    q.append(i)

            while q:
                u = q.popleft()
                for v in adj[u]:
                    if degree[v] > 0:
                        degree[v] -= 1
                degree[u] = 0

        # Count remaining edges
        remaining_edges = sum(degree)
        return max(0, 2 * (remaining_edges - 1)) if remaining_edges > 0 else 0