import math

class Solution:
    def kthSmallestAmount(self, coins: list[int], k: int) -> int:

        def get_lcm_for_subset(subset_coins: list[int], limit: int) -> int:
            """
            Calculates the LCM of a list of coins.
            Returns `limit + 1` if the LCM exceeds `limit` at any point during calculation,
            to signify that it's too large for the current `x`.
            """
            current_lcm = 1
            for coin in subset_coins:
                # Calculate GCD
                g = math.gcd(current_lcm, coin)

                # Check if current_lcm * (coin // g) would exceed the limit.
                # This prevents `current_lcm` from growing unnecessarily large beyond `limit`
                # and ensures that `current_lcm * (coin // g)` does not overflow (though Python handles large ints).
                # If `current_lcm` is already greater than `limit` divided by `coin // g`,
                # then the next `current_lcm` will definitely be greater than `limit`.
                if current_lcm > limit // (coin // g):
                    return limit + 1

                # Update current_lcm
                current_lcm = current_lcm * (coin // g)
            return current_lcm

        def check(x: int) -> int:
            """
            Calculates the count of amounts less than or equal to `x` that can be formed
            by combining the given denominations using the Principle of Inclusion-Exclusion.
            """
            count = 0
            n = len(coins)

            # Iterate through all non-empty subsets of `coins` using a bitmask
            for i in range(1, 1 << n):
                subset = []
                parity = 0 # To track if the subset size is odd or even
                for j in range(n):
                    if (i >> j) & 1: # If the j-th coin is in the current subset
                        subset.append(coins[j])
                        parity += 1

                # Calculate the LCM for the current subset
                lcm_val = get_lcm_for_subset(subset, x)

                # If lcm_val is greater than x, it means there are no multiples of this LCM <= x
                if lcm_val > x:
                    term = 0
                else:
                    term = x // lcm_val

                # Apply inclusion-exclusion principle based on subset parity
                if parity % 2 == 1: # Odd number of elements in subset, add term
                    count += term
                else: # Even number of elements in subset, subtract term
                    count -= term
            return count

        # Binary search for the Kth smallest amount
        # The search space for the answer `x` is from 1 to a maximum possible value.
        # Max `k` is 10^9, max `coins[i]` is 10^5.
        # A safe upper bound for the answer is `k * max(coins)`.
        # In the worst case, if `coins = [10^5]` and `k = 10^9`, the answer is `10^5 * 10^9 = 10^14`.
        L = 1
        R = 10**14 
        ans = R # Initialize answer with a value that is definitely >= the true answer

        while L <= R:
            mid = (L + R) // 2
            # If `check(mid)` returns a count >= k, then `mid` could be our answer.
            # We try to find a smaller `mid` by searching in the left half.
            if check(mid) >= k:
                ans = mid
                R = mid - 1
            # If `check(mid)` returns a count < k, then `mid` is too small.
            # We need to search in the right half for a larger `mid`.
            else:
                L = mid + 1

        return ans