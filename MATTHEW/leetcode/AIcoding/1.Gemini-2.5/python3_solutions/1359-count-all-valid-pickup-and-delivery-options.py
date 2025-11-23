class Solution:
    def countOrders(self, n: int) -> int:
        MOD = 10**9 + 7

        # The number of ways to arrange n pickup and n delivery options
        # such that each pickup Pi occurs before its corresponding delivery Di
        # can be derived using a combinatorial approach.
        #
        # Let f(n) be the number of valid sequences for n orders.
        # For n=1, we have (P1, D1), so f(1) = 1.
        #
        # For n orders, consider placing the n-th pickup (Pn) and delivery (Dn).
        # There are 2n total positions in the sequence.
        # We need to choose 2 positions for Pn and Dn. This can be done in C(2n, 2) ways.
        # Once the positions are chosen, Pn must come before Dn, so there's only 1 way to arrange them.
        # The remaining (2n - 2) positions must be filled by the (n-1) previous orders
        # in f(n-1) ways.
        #
        # So, f(n) = C(2n, 2) * f(n-1)
        # f(n) = ( (2n) * (2n - 1) / 2 ) * f(n-1)
        # f(n) = n * (2n - 1) * f(n-1)
        #
        # Let's check:
        # f(1) = 1
        # f(2) = 2 * (2*2 - 1) * f(1) = 2 * 3 * 1 = 6
        # f(3) = 3 * (2*3 - 1) * f(2) = 3 * 5 * 6 = 90
        #
        # This recurrence relation can be computed iteratively.
        # The result can be very large, so we need to take modulo 10^9 + 7.

        ans = 1
        for i in range(1, n + 1):
            # Multiply by i (for n)
            ans = (ans * i) % MOD
            # Multiply by (2i - 1) (for 2n - 1)
            ans = (ans * (2 * i - 1)) % MOD

        return ans