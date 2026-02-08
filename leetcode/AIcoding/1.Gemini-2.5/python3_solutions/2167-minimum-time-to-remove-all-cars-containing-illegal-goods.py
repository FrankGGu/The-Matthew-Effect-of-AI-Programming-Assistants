class Solution:
    def minimumTime(self, s: str) -> int:
        n = len(s)

        prefix_ones = [0] * (n + 1)
        for i in range(n):
            prefix_ones[i+1] = prefix_ones[i] + (1 if s[i] == '1' else 0)

        # The total cost for a chosen split is:
        # i (cost to remove s[0...i-1] from left)
        # + (n - k) (cost to remove s[k...n-1] from right)
        # + 2 * (prefix_ones[k] - prefix_ones[i]) (cost to remove '1's in s[i...k-1] from middle)
        # We need to minimize this for all 0 <= i <= k <= n.

        # Rearranging the terms:
        # cost = (i - 2 * prefix_ones[i]) + (n - k + 2 * prefix_ones[k])
        # Let f(x) = x - 2 * prefix_ones[x]
        # Let g(x) = n - x + 2 * prefix_ones[x]
        # We want to minimize f(i) + g(k) where 0 <= i <= k <= n.

        min_total_cost = float('inf')
        min_f_i_so_far = float('inf')

        # Iterate k from 0 to n.
        # For each k, we consider it as the end of the middle segment (exclusive).
        # 'i' can be any value from 0 up to k.
        # So we need the minimum f(i) for i <= k.
        for k in range(n + 1):
            # Calculate f(k) for the current k. This k can also be an 'i' value.
            current_f_k = k - 2 * prefix_ones[k]
            min_f_i_so_far = min(min_f_i_so_far, current_f_k)

            # Calculate g(k) for the current k.
            current_g_k = (n - k) + 2 * prefix_ones[k]

            # The minimum cost for this k is min_f_i_so_far + current_g_k
            min_total_cost = min(min_total_cost, min_f_i_so_far + current_g_k)

        return min_total_cost