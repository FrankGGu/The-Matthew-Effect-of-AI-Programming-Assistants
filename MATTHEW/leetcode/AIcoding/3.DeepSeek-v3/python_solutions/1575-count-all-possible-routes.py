class Solution:
    def countRoutes(self, locations: List[int], start: int, finish: int, fuel: int) -> int:
        MOD = 10**9 + 7
        n = len(locations)
        memo = {}

        def dfs(current, remaining_fuel):
            if remaining_fuel < 0:
                return 0
            if (current, remaining_fuel) in memo:
                return memo[(current, remaining_fuel)]

            total = 0
            if current == finish:
                total = 1

            for next_city in range(n):
                if next_city == current:
                    continue
                cost = abs(locations[current] - locations[next_city])
                if remaining_fuel >= cost:
                    total += dfs(next_city, remaining_fuel - cost)
                    total %= MOD

            memo[(current, remaining_fuel)] = total % MOD
            return memo[(current, remaining_fuel)]

        return dfs(start, fuel)