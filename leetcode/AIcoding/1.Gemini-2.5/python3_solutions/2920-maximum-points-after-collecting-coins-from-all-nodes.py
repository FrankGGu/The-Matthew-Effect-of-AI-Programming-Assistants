import collections
import math

class Solution:
    def maximumPoints(self, edges: list[list[int]], coins: list[int], k: int) -> int:
        n = len(coins)
        adj = collections.defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        # dp[u][j] will store the maximum coins collected from the subtree rooted at u,
        # having used exactly j halving operations within this subtree.
        # j ranges from 0 to k.

        # The dfs function returns a list (DP array) where dp_array[j] is the max coins
        # for the current subtree using j halvings.
        def dfs(u, parent):
            # Initialize dp_u for node u itself.
            # dp_u[0] means we collect coins[u] (0 halvings for u).
            # dp_u[1] means we collect coins[u] // 2 (1 halving for u).
            # All other dp_u[j] for j > 1 are not directly from node u itself,
            # but from combining with children.

            # Initialize dp_u with negative infinity for all halving counts.
            # This array will be updated as we process children.
            # The current state of dp_u represents the max coins from u and its
            # already processed children, for different halving counts.

            dp_u = [-math.inf] * (k + 1)

            # Option 1 for node u: Don't halve u. Contributes coins[u], uses 0 halvings.
            dp_u[0] = coins[u]

            # Option 2 for node u: Halve u. Contributes coins[u] // 2, uses 1 halving.
            # This is only possible if k >= 1.
            if k >= 1:
                dp_u[1] = max(dp_u[1], coins[u] // 2) # Use max in case dp_u[1] was already set (not the case here initially)

            for v in adj[u]:
                if v == parent:
                    continue

                dp_v = dfs(v, u) # Recursively get DP results for child v's subtree

                # Create a temporary DP array to store results after merging child v
                temp_dp_u = [-math.inf] * (k + 1)

                # Iterate through all possible halving counts for the current subtree
                # (u + previously processed children)
                for j_u_current in range(k + 1):
                    if dp_u[j_u_current] == -math.inf:
                        continue # Skip if this state is unreachable from u and its processed children

                    # Iterate through all possible halving counts for child v's subtree
                    for j_v_current in range(k + 1):
                        if dp_v[j_v_current] == -math.inf:
                            continue # Skip if this state is unreachable from child v's subtree

                        # If total halvings (j_u_current + j_v_current) do not exceed k
                        if j_u_current + j_v_current <= k:
                            # Update temp_dp_u with the maximum possible coins for this combined state
                            temp_dp_u[j_u_current + j_v_current] = max(
                                temp_dp_u[j_u_current + j_v_current],
                                dp_u[j_u_current] + dp_v[j_v_current]
                            )
                dp_u = temp_dp_u # Update dp_u with the merged results

            return dp_u

        # Start DFS from the root (node 0) with no parent (-1)
        final_dp_results = dfs(0, -1)

        # The maximum points will be the maximum value in the final DP array for the root
        return max(final_dp_results)