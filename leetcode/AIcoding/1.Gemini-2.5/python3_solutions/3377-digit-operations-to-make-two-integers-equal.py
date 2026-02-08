import functools

class Solution:
    def minCost(self, num1: int, num2: int, cost1: int, cost2: int) -> int:
        s1 = str(num1)
        s2 = str(num2)

        # Pad numbers with leading zeros to ensure same length, plus 2 for potential carry/borrow at MSB.
        # This handles cases like 99 -> 100 or 100 -> 99, where the number of digits changes.
        max_len = max(len(s1), len(s2))
        N = max_len + 2 

        s1_padded = [int(d) for d in s1.zfill(N)]
        s2_padded = [int(d) for d in s2.zfill(N)]

        # Reverse digits so LSB (least significant bit) is at index 0.
        # This allows processing from right to left, which is natural for carries.
        s1_padded.reverse()
        s2_padded.reverse()

        @functools.lru_cache(None)
        def solve(idx, carry):
            # Base case: if all digits processed (from LSB to MSB)
            if idx == N:
                # If there's no remaining carry, cost is 0. Otherwise, it's impossible to make them equal.
                return 0 if carry == 0 else float('inf')

            d1 = s1_padded[idx]
            d2 = s2_padded[idx]

            min_total_cost = float('inf')

            # We need to make (d1 + carry) effectively equal to d2 at this position.
            # The `carry` argument represents the carry/borrow propagated from position `idx-1`.

            # Determine the target digit `d1_prime` for `s1_padded[idx]` such that
            # (d1_prime + carry) % 10 == d2.
            # `d1_prime` must be a valid digit [0-9].
            # `target_d1_val` is `d1_prime`.
            target_d1_val = (d2 - (carry % 10) + 10) % 10

            # Calculate the cost of `cost1` operations to change `d1` to `target_d1_val`.
            # This is the minimum number of single-digit increments/decrements.
            cost1_ops_needed = min(abs(d1 - target_d1_val), 10 - abs(d1 - target_d1_val))
            current_cost1 = cost1_ops_needed * cost1

            # Calculate the base carry to pass to the next digit (idx+1).
            # This `next_carry_base` is what remains after `d1` (modified to `target_d1_val`)
            # and `carry` are combined to match `d2`.
            # Effectively, it's ((modified_d1 + carry) - d2) / 10.
            next_carry_base = (target_d1_val + carry - d2) // 10

            # Explore three possibilities for `cost2` operations at this "level" of carry propagation:

            # Case 1: No `cost2` operation (increment/decrement `num1` by 1) is applied
            # The cost is `current_cost1` plus the cost from the next state.
            min_total_cost = min(min_total_cost, current_cost1 + solve(idx + 1, next_carry_base))

            # Case 2: Apply a `+1` operation to `num1` (cost `cost2`)
            # This effectively increments the carry that is passed to the next digit (`idx+1`) by 1.
            # The cost is `cost2` plus `current_cost1` plus the cost from the next state.
            min_total_cost = min(min_total_cost, cost2 + current_cost1 + solve(idx + 1, next_carry_base + 1))

            # Case 3: Apply a `-1` operation to `num1` (cost `cost2`)
            # This effectively decrements the carry that is passed to the next digit (`idx+1`) by 1.
            # The cost is `cost2` plus `current_cost1` plus the cost from the next state.
            min_total_cost = min(min_total_cost, cost2 + current_cost1 + solve(idx + 1, next_carry_base - 1))

            return min_total_cost

        # Initial call: start from the least significant digit (index 0) with no initial carry.
        return solve(0, 0)