import collections

class Solution:
    def numWays(self, n: int, relation: list[list[int]], k: int) -> int:
        adj = [[] for _ in range(n)]
        for u, v in relation:
            adj[u].append(v)

        dp = [0] * n
        dp[0] = 1

        for _ in range(k):
            next_dp = [0] * n
            for player_idx in range(n):
                if dp[player_idx] > 0:
                    for next_player_idx in adj[player_idx]:
                        next_dp[next_player_idx] += dp[player_idx]
            dp = next_dp

        return dp[n - 1]