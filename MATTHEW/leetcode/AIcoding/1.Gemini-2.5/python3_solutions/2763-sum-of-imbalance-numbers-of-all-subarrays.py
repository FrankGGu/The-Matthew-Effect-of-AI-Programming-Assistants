class Solution:
    def sumImbalanceNumbers(self, nums: list[int]) -> int:
        n = len(nums)
        total_imbalance_sum = 0

        for i in range(n):
            seen = set()
            num_unique = 0
            num_consecutive_pairs = 0
            for j in range(i, n):
                x = nums[j]

                if x not in seen:
                    seen.add(x)
                    num_unique += 1

                    # Check if x forms a consecutive pair with x-1 or x+1
                    # If x-1 is already in the set, it forms a (x-1, x) consecutive pair.
                    if (x - 1) in seen:
                        num_consecutive_pairs += 1
                    # If x+1 is already in the set, it forms a (x, x+1) consecutive pair.
                    if (x + 1) in seen:
                        num_consecutive_pairs += 1

                # The imbalance number of a subarray S is defined as the count of pairs (u_k, u_{k+1})
                # from its sorted unique elements such that u_{k+1} - u_k > 1.
                # This can be calculated as:
                # (Total number of adjacent pairs in sorted unique elements) - (Number of adjacent pairs with difference 1)
                # Total number of adjacent pairs in sorted unique elements is (num_unique - 1) if num_unique >= 1.
                # If num_unique < 2, there are no adjacent pairs, so imbalance is 0.
                # The expression (num_unique - 1) - num_consecutive_pairs correctly counts imbalances.
                # We use max(0, ...) to ensure it's non-negative, especially for num_unique < 2.

                if num_unique >= 1: # Only calculate if there's at least one unique element
                    current_imbalance = (num_unique - 1) - num_consecutive_pairs
                    total_imbalance_sum += current_imbalance

        return total_imbalance_sum