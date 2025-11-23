class Solution:
    def minimumTotalDistance(self, robots: list[int], factories: list[list[int]]) -> int:
        robots.sort()
        factories.sort()
        n = len(robots)
        m = len(factories)

        dp = {}

        def solve(robot_idx, factory_idx, used):
            if robot_idx == n:
                return 0

            if (robot_idx, factory_idx, used) in dp:
                return dp[(robot_idx, factory_idx, used)]

            if factory_idx == m:
                return float('inf')

            ans = float('inf')

            # Don't use current factory
            ans = min(ans, solve(robot_idx, factory_idx + 1, 0))

            # Use current factory
            if used < factories[factory_idx][1]:
                cost = abs(robots[robot_idx] - factories[factory_idx][0])
                ans = min(ans, cost + solve(robot_idx + 1, factory_idx, used + 1))

            dp[(robot_idx, factory_idx, used)] = ans
            return ans

        return solve(0, 0, 0)