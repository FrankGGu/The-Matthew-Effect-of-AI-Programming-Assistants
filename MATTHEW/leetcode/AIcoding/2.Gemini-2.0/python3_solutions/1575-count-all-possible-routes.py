class Solution:
    def countRoutes(self, locations: List[int], start: int, finish: int, fuel: int) -> int:
        n = len(locations)
        dp = {}

        def solve(curr, fuel_left):
            if (curr, fuel_left) in dp:
                return dp[(curr, fuel_left)]

            count = 0
            if curr == finish:
                count = 1

            for next_city in range(n):
                if next_city != curr:
                    cost = abs(locations[curr] - locations[next_city])
                    if fuel_left >= cost:
                        count = (count + solve(next_city, fuel_left - cost)) % (10**9 + 7)

            dp[(curr, fuel_left)] = count
            return count

        return solve(start, fuel)