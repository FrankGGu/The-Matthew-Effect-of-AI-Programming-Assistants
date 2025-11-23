import math

class Solution:
    def minimumTotalDistance(self, robots: list[list[int]], factories: list[list[int]]) -> int:
        # Sort both robots and factories by their positions.
        # This is crucial for the dynamic programming approach to work,
        # as it ensures that optimal assignments do not "cross over".
        robots.sort()
        factories.sort()

        N = len(robots)
        M = len(factories)

        # dp[i][j] represents the minimum cost to repair the first 'i' robots
        # (robots from index 0 to i-1) using the first 'j' factories
        # (factories from index 0 to j-1).
        # Initialize with infinity, as we are looking for a minimum.
        dp = [[float('inf')] * (M + 1) for _ in range(N + 1)]

        # Base case: It costs 0 to repair 0 robots, regardless of how many factories are available.
        for j in range(M + 1):
            dp[0][j] = 0

        # Iterate through each factory
        for j in range(1, M + 1):
            # Iterate through each robot (or number of robots to be repaired)
            for i in range(1, N + 1):
                # Option 1: The current factory (factories[j-1]) is NOT used to repair
                # any of the first 'i' robots.
                # In this case, the first 'i' robots must be repaired by the first 'j-1' factories.
                dp[i][j] = dp[i][j-1]

                # Option 2: The current factory (factories[j-1]) IS used to repair some robots.
                # We consider assigning a contiguous block of robots (from index k-1 to i-1)
                # to the current factory (factories[j-1]).
                current_health_sum = 0  # Total health units of robots assigned to factories[j-1]
                current_cost_sum = 0    # Total cost for these robots assigned to factories[j-1]

                # Iterate backwards from robot i-1 down to robot 0.
                # 'k' represents the number of robots *not* repaired by factories[j-1]
                # (i.e., robots from index 0 to k-2).
                # So, robots from index k-1 to i-1 are being considered for factories[j-1].
                for k in range(i, 0, -1):
                    robot_pos, robot_health = robots[k-1]
                    factory_pos, factory_capacity = factories[j-1]

                    current_health_sum += robot_health
                    # The cost for a robot is its health multiplied by the distance to the factory.
                    current_cost_sum += robot_health * abs(robot_pos - factory_pos)

                    # Check if the current factory has enough capacity for these robots.
                    if current_health_sum > factory_capacity:
                        break # Cannot assign these robots to factories[j-1], stop trying more robots for this factory.

                    # If the previous state (repairing k-1 robots with j-1 factories) is reachable,
                    # update dp[i][j].
                    if dp[k-1][j-1] != float('inf'):
                        dp[i][j] = min(dp[i][j], dp[k-1][j-1] + current_cost_sum)

        # The final answer is the minimum cost to repair all N robots using all M factories.
        return dp[N][M]