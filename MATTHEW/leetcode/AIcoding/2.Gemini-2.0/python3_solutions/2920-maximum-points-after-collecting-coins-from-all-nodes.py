class Solution:
    def maximumPoints(self, edges: list[list[int]], coins: list[int], k: int) -> int:
        n = len(coins)
        graph = [[] for _ in range(n)]
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        dp = {}

        def dfs(node, parent, shifts):
            if (node, shifts) in dp:
                return dp[(node, shifts)]

            no_shift = coins[node] // (2**shifts) - k
            shift = coins[node] // (2**(shifts+1))

            max_no_shift = no_shift
            max_shift = shift

            for neighbor in graph[node]:
                if neighbor != parent:
                    max_no_shift += dfs(neighbor, node, shifts)
                    if shifts < 20:
                        max_shift += dfs(neighbor, node, shifts + 1)
                    else:
                        max_shift = float('-inf')

            dp[(node, shifts)] = max(max_no_shift, max_shift)
            return dp[(node, shifts)]

        return dfs(0, -1, 0)