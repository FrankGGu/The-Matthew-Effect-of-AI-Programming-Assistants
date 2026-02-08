import functools

class Solution:
    def countRoutes(self, locations: list[int], start: int, finish: int, fuel: int) -> int:
        n = len(locations)
        MOD = 10**9 + 7

        @functools.lru_cache(None)
        def dfs(current_city: int, current_fuel: int) -> int:
            routes = 0
            if current_city == finish:
                routes = 1

            for next_city in range(n):
                if next_city == current_city:
                    continue

                fuel_cost = abs(locations[current_city] - locations[next_city])

                if current_fuel >= fuel_cost:
                    routes = (routes + dfs(next_city, current_fuel - fuel_cost)) % MOD

            return routes

        return dfs(start, fuel)