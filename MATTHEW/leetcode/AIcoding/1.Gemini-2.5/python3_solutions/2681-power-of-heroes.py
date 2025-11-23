class Solution:
    def sumOfPower(self, heroes: list[int]) -> int:
        MOD = 10**9 + 7

        heroes.sort()

        total_power = 0
        # current_sum_for_min stores the sum of (heroes[j] * 2^(i - 1 - j)) for j from 0 to i-1.
        # This represents the sum of minimum elements' contributions for subsequences
        # where heroes[i] is the maximum element and heroes[j] (j < i) is the minimum element.
        # It follows the recurrence: S[i+1] = heroes[i] + 2 * S[i]
        current_sum_for_min = 0 

        for h_i in heroes:
            # Calculate h_i^2 modulo MOD
            h_i_sq = (h_i * h_i) % MOD

            # The total contribution for the current h_i being the maximum element in a subsequence is:
            # (h_i^2 * h_i)  -> for the subsequence [h_i] (h_i is both min and max)
            # + (h_i^2 * current_sum_for_min) -> for subsequences where h_i is max and some h_j (j < i) is min.
            #   current_sum_for_min = sum(heroes[j] * 2^(i - 1 - j) for j in 0 to i-1)
            #   The term 2^(i - 1 - j) accounts for the choices of elements between h_j and h_i.

            # Combine these two parts: h_i_sq * (h_i + current_sum_for_min)
            contribution_for_h_i_as_max = (h_i_sq * (h_i + current_sum_for_min)) % MOD

            total_power = (total_power + contribution_for_h_i_as_max) % MOD

            # Update current_sum_for_min for the next iteration (i+1)
            # The new sum will include h_i itself (multiplied by 2^0) and
            # the previous sum's terms multiplied by 2.
            current_sum_for_min = (h_i + (2 * current_sum_for_min) % MOD) % MOD

        return total_power