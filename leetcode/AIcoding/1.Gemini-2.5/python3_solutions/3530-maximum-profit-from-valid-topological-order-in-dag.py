import collections

class Solution:
    def maxProfit(self, n: int, dependencies: list[list[int]], profits: list[int]) -> int:
        if n == 0:
            return 0

        adj = collections.defaultdict(list)
        in_degree = [0] * n

        for u, v in dependencies:
            adj[u].append(v)
            in_degree[v] += 1

        # dp[i] stores the maximum profit of any valid topological path ending at node i.
        # Initialize with negative infinity to correctly handle paths that cannot be formed
        # or to ensure that only valid paths starting from in-degree 0 nodes contribute.
        # This is crucial if profits can be negative.
        dp = [float('-inf')] * n 

        q = collections.deque()

        # Initialize queue with all nodes having an in-degree of 0.
        # These are the potential starting points of topological paths.
        for i in range(n):
            if in_degree[i] == 0:
                q.append(i)
                # The profit for a path ending at itself is just its own profit.
                dp[i] = profits[i] 

        max_overall_profit = float('-inf')

        while q:
            u = q.popleft()
            # Update the overall maximum profit found so far
            max_overall_profit = max(max_overall_profit, dp[u])

            for v in adj[u]:
                # If we reach v from u, the profit of the path ending at v could be dp[u] + profits[v].
                # We take the maximum of current dp[v] and this new path's profit.
                dp[v] = max(dp[v], dp[u] + profits[v])

                in_degree[v] -= 1
                if in_degree[v] == 0:
                    q.append(v)

        # After processing all reachable nodes, max_overall_profit holds the maximum.
        # Since n > 0 and a DAG always has at least one node with in-degree 0,
        # at least one node will be added to the queue, and max_overall_profit will be updated
        # from float('-inf') to at least the profit of that initial node.
        return max_overall_profit