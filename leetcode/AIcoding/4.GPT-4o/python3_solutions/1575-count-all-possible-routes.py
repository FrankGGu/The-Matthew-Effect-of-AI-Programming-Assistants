class Solution:
    def countRoutes(self, locations: List[int], start: int, finish: int, fuel: int) -> int:
        mod = 10**9 + 7
        n = len(locations)
        dp = [[-1] * (fuel + 1) for _ in range(n)]

        def dfs(pos, fuel_left):
            if dp[pos][fuel_left] != -1:
                return dp[pos][fuel_left]
            count = 1 if pos == finish else 0
            for next_pos in range(n):
                if next_pos != pos:
                    cost = abs(locations[next_pos] - locations[pos])
                    if fuel_left >= cost:
                        count = (count + dfs(next_pos, fuel_left - cost)) % mod
            dp[pos][fuel_left] = count
            return count

        return dfs(start, fuel)