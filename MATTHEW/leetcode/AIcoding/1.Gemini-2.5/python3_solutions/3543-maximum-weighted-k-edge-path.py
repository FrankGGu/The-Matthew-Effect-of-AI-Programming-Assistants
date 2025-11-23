class Solution:
    def maxWeightedKEdgePath(self, n: int, edges: list[list[int]], k: int) -> int:
        # dp[i][j] will store the maximum weight of a path with 'i' edges ending at node 'j'.
        # Initialize with -float('inf') to represent unreachable states.
        # A path of 0 edges has 0 weight.
        dp = [[-float('inf')] * n for _ in range(k + 1)]

        # Base case: A path of 0 edges starts and ends at the same node with 0 weight.
        # This assumes we can start a path at any node.
        for i in range(n):
            dp[0][i] = 0

        # Fill the DP table
        # Iterate for each path length from 1 to k
        for i in range(1, k + 1):
            # Iterate through all available edges (u -> v) with weight w
            for u, v, w in edges:
                # If there's a valid path of length i-1 ending at 'u'
                if dp[i-1][u] != -float('inf'):
                    # We can extend this path by adding the edge (u -> v)
                    # Update the maximum weight for a path of length 'i' ending at 'v'
                    dp[i][v] = max(dp[i][v], dp[i-1][u] + w)

        # After filling the DP table up to k edges,
        # the maximum weight K-edge path is the maximum value in dp[k]
        max_weight = -float('inf')
        for weight in dp[k]:
            max_weight = max(max_weight, weight)

        # If max_weight is still -float('inf'), it means no path of length k exists.
        # Return -1 in this case, which is a common practice for problems asking for max/min values
        # when no valid path is found.
        if max_weight == -float('inf'):
            return -1
        else:
            return max_weight