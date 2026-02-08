import collections

class Solution:
    def maximumValueSum(self, nums: list[int], k: int, edges: list[list[int]]) -> int:
        n = len(nums)
        adj = collections.defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        base_sum = 0
        for u, v in edges:
            base_sum += nums[u] ^ nums[v]

        # dfs returns (max_gain_even_parity, max_gain_odd_parity)
        # max_gain_even_parity: max additional gain from subtree rooted at u,
        #                       if total count of flipped nodes in subtree u (including u) is even.
        # max_gain_odd_parity: max additional gain from subtree rooted at u,
        #                      if total count of flipped nodes in subtree u (including u) is odd.
        # The 'additional gain' is relative to the base sum.

        # We need to track two possibilities for node u's state: x_u=0 and x_u=1.
        # dp_u_even: max gain if x_u=0 and total_flipped in subtree u is even
        # dp_u_odd: max gain if x_u=0 and total_flipped in subtree u is odd
        # dp_u_even_flipped: max gain if x_u=1 and total_flipped in subtree u is even
        # dp_u_odd_flipped: max gain if x_u=1 and total_flipped in subtree u is odd
        # All gains are relative to the (nums[u]^nums[v]) for edges.
        # A value of -float('inf') indicates an unreachable state.

        def dfs(u, p):
            # Initial state for node u itself (before considering children)
            # If x_u=0: total flipped count is 0 (even). Gain is 0.
            dp_u_even = 0
            dp_u_odd = -float('inf')

            # If x_u=1: total flipped count is 1 (odd). Gain is 0.
            dp_u_even_flipped = -float('inf')
            dp_u_odd_flipped = 0

            for v in adj[u]:
                if v == p:
                    continue

                # Recursively get results for child v
                res_v_even, res_v_odd = dfs(v, u)

                # Calculate the potential gain for edge (u,v)
                # If x_u != x_v, edge value is (nums[u]^nums[v]^k).
                # If x_u == x_v, edge value is (nums[u]^nums[v]).
                # Gain is (nums[u]^nums[v]^k) - (nums[u]^nums[v]) if x_u != x_v, else 0.
                gain_uv = max(0, (nums[u] ^ nums[v] ^ k) - (nums[u] ^ nums[v]))

                # Temporary variables to store next DP states after processing child v
                next_dp_u_even = -float('inf')
                next_dp_u_odd = -float('inf')
                next_dp_u_even_flipped = -float('inf')
                next_dp_u_odd_flipped = -float('inf')

                # Case 1: x_u = 0
                #   Subcase 1.1: x_v = 0 (edge (u,v) contributes 0 gain)
                #     Combine current (dp_u_even, dp_u_odd) with (res_v_even, res_v_odd)
                if dp_u_even != -float('inf'):
                    if res_v_even != -float('inf'): # even + even -> even
                        next_dp_u_even = max(next_dp_u_even, dp_u_even + res_v_even)
                    if res_v_odd != -float('inf'):  # even + odd -> odd
                        next_dp_u_odd = max(next_dp_u_odd, dp_u_even + res_v_odd)
                if dp_u_odd != -float('inf'):
                    if res_v_even != -float('inf'): # odd + even -> odd
                        next_dp_u_odd = max(next_dp_u_odd, dp_u_odd + res_v_even)
                    if res_v_odd != -float('inf'):  # odd + odd -> even
                        next_dp_u_even = max(next_dp_u_even, dp_u_odd + res_v_odd)

                #   Subcase 1.2: x_v = 1 (edge (u,v) contributes gain_uv)
                #     Combine current (dp_u_even, dp_u_odd) with (res_v_even, res_v_odd) and add gain_uv
                if dp_u_even != -float('inf'):
                    if res_v_even != -float('inf'): # even + even -> even (with gain)
                        next_dp_u_even = max(next_dp_u_even, dp_u_even + res_v_even + gain_uv)
                    if res_v_odd != -float('inf'):  # even + odd -> odd (with gain)
                        next_dp_u_odd = max(next_dp_u_odd, dp_u_even + res_v_odd + gain_uv)
                if dp_u_odd != -float('inf'):
                    if res_v_even != -float('inf'): # odd + even -> odd (with gain)
                        next_dp_u_odd = max(next_dp_u_odd, dp_u_odd + res_v_even + gain_uv)
                    if res_v_odd != -float('inf'):  # odd + odd -> even (with gain)
                        next_dp_u_even = max(next_dp_u_even, dp_u_odd + res_v_odd + gain_uv)

                # Update dp_u_even, dp_u_odd for next child or return
                dp_u_even, dp_u_odd = next_dp_u_even, next_dp_u_odd

                # Case 2: x_u = 1
                #   Subcase 2.1: x_v = 1 (edge (u,v) contributes 0 gain)
                #     Combine current (dp_u_even_flipped, dp_u_odd_flipped) with (res_v_even, res_v_odd)
                if dp_u_even_flipped != -float('inf'):
                    if res_v_even != -float('inf'): # even + even -> even
                        next_dp_u_even_flipped = max(next_dp_u_even_flipped, dp_u_even_flipped + res_v_even)
                    if res_v_odd != -float('inf'):  # even + odd -> odd
                        next_dp_u_odd_flipped = max(next_dp_u_odd_flipped, dp_u_even_flipped + res_v_odd)
                if dp_u_odd_flipped != -float('inf'):
                    if res_v_even != -float('inf'): # odd + even -> odd
                        next_dp_u_odd_flipped = max(next_dp_u_odd_flipped, dp_u_odd_flipped + res_v_even)
                    if res_v_odd != -float('inf'):  # odd + odd -> even
                        next_dp_u_even_flipped = max(next_dp_u_even_flipped, dp_u_odd_flipped + res_v_odd)

                #   Subcase 2.2: x_v = 0 (edge (u,v) contributes gain_uv)
                #     Combine current (dp_u_even_flipped, dp_u_odd_flipped) with (res_v_even, res_v_odd) and add gain_uv
                if dp_u_even_flipped != -float('inf'):
                    if res_v_even != -float('inf'): # even + even -> even (with gain)
                        next_dp_u_even_flipped = max(next_dp_u_even_flipped, dp_u_even_flipped + res_v_even + gain_uv)
                    if res_v_odd != -float('inf'):  # even + odd -> odd (with gain)
                        next_dp_u_odd_flipped = max(next_dp_u_odd_flipped, dp_u_even_flipped + res_v_odd + gain_uv)
                if dp_u_odd_flipped != -float('inf'):
                    if res_v_even != -float('inf'): # odd + even -> odd (with gain)
                        next_dp_u_odd_flipped = max(next_dp_u_odd_flipped, dp_u_odd_flipped + res_v_even + gain_uv)
                    if res_v_odd != -float('inf'):  # odd + odd -> even (with gain)
                        next_dp_u_even_flipped = max(next_dp_u_even_flipped, dp_u_odd_flipped + res_v_odd + gain_uv)

                # Update dp_u_even_flipped, dp_u_odd_flipped for next child or return
                dp_u_even_flipped, dp_u_odd_flipped = next_dp_u_even_flipped, next_dp_u_odd_flipped

            # At the end, for node u, we can choose x_u=0 or x_u=1.
            # We want to return the max gain for even/odd total flipped count in subtree u.
            return max(dp_u_even, dp_u_even_flipped), max(dp_u_odd, dp_u_odd_flipped)

        # Start DFS from node 0 (arbitrary root for a tree)
        final_even_gain, _ = dfs(0, -1)

        # The total number of flipped nodes must be even.
        # So we take the max gain corresponding to an even total flipped count.
        return base_sum + final_even_gain