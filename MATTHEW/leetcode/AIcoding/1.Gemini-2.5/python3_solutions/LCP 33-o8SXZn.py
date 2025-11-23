import math

class Solution:
    def storeWater(self, bucket: list[int], vat: list[int]) -> int:
        n = len(bucket)

        max_vat_val = 0
        all_vats_zero = True
        for v in vat:
            if v > 0:
                all_vats_zero = False
            max_vat_val = max(max_vat_val, v)

        if all_vats_zero:
            return 0

        # Function to calculate total cost for a given k (number of pour operations)
        def calculate_total_cost(k_val):
            current_upgrades = 0
            for i in range(n):
                if vat[i] == 0:
                    continue

                # target_bucket_capacity = ceil(vat[i] / k_val)
                # This is the minimum capacity bucket[i] needs to have
                # to fill vat[i] in k_val pour operations.
                target_bucket_capacity = (vat[i] + k_val - 1) // k_val

                # Calculate upgrades needed for this bucket
                # If current bucket capacity is less than target, upgrade it.
                current_upgrades += max(0, target_bucket_capacity - bucket[i])

            # Total cost is k_val (for pour operations) + total upgrades
            return k_val + current_upgrades

        # Ternary search for k (number of pour operations)
        # k must be at least 1 since not all vats are zero.
        left = 1

        # Determine a safe upper bound for k.
        # The total cost is k + sum(upgrades).
        # If k is very large, say k > max_vat_val, then ceil(vat[i]/k) becomes 1 for vat[i]>0.
        # In this case, sum(upgrades) is sum(max(0, 1 - bucket[i])) which is at most N.
        # So, for k > max_vat_val, the cost function is k + (a value <= N), which is increasing.
        # Thus, the minimum will not be in this range, or it will be at k = max_vat_val.
        # The maximum possible answer is roughly max_vat_val + N (e.g., if k=max_vat_val and all buckets are 0 and all vats are max_vat_val).
        # So, the optimal k will not exceed max_vat_val + N.
        right = max_vat_val + n 

        # Ternary search for about 100 iterations.
        # log_3(10^9) is approximately 19, so 100 iterations is more than enough
        # to converge to the minimum for a range of 10^9.
        for _ in range(100): 
            m1 = left + (right - left) // 3
            m2 = right - (right - left) // 3

            # Ensure m1 and m2 are distinct to avoid infinite loop when range is small
            if m1 >= m2: 
                break

            cost1 = calculate_total_cost(m1)
            cost2 = calculate_total_cost(m2)

            if cost1 < cost2:
                right = m2 - 1
            else:
                left = m1 + 1

        # After the loop, the minimum is guaranteed to be in a small interval [left, right].
        # Check values in this small interval to find the exact minimum.
        # Adding a small buffer (e.g., -2 to +2) to cover edge cases due to integer arithmetic.
        min_total_cost = float('inf')
        for k_val in range(max(1, left - 2), right + 3):
            if k_val >= 1: # Ensure k is always at least 1
                min_total_cost = min(min_total_cost, calculate_total_cost(k_val))

        return min_total_cost