class Solution:
    def minIncrementForTargetMultiples(self, nums: list[int], k: int) -> int:

        if not nums:
            return 0

        max_orig = max(nums)

        cost_if_max_orig_is_final_max = 0
        max_val_of_smaller_elements_after_increment = 0

        for x in nums:
            if x < max_orig:
                # Calculate the smallest multiple of k that is greater than or equal to x
                # This is equivalent to ceil(x / k) * k
                target_x = (x + k - 1) // k * k

                cost_if_max_orig_is_final_max += (target_x - x)
                max_val_of_smaller_elements_after_increment = max(max_val_of_smaller_elements_after_increment, target_x)

        # Scenario 1: The original maximum (max_orig) can remain the final maximum.
        # This is possible if all elements 'x' that were originally less than max_orig,
        # after being incremented to 'target_x' (a multiple of k), are still strictly less than max_orig.
        if max_val_of_smaller_elements_after_increment < max_orig:
            return cost_if_max_orig_is_final_max
        else:
            # Scenario 2: The original maximum (max_orig) cannot remain the final maximum.
            # This happens if some element 'x' (originally less than max_orig)
            # had to be incremented to 'target_x' such that 'target_x' is greater than or equal to max_orig.
            # In this case, the final maximum must be at least 'max_val_of_smaller_elements_after_increment'.
            # To satisfy the condition, the most optimal strategy is to make *all* elements
            # their respective smallest multiple of k that is greater than or equal to them.
            # The final maximum will then be max(ceil(val / k) * k for val in nums).
            # All elements will be multiples of k, and the condition "nums[i] < max(nums)"
            # will be satisfied for all relevant elements.

            cost_all_elements_to_multiples = 0
            for x in nums:
                target_x = (x + k - 1) // k * k
                cost_all_elements_to_multiples += (target_x - x)
            return cost_all_elements_to_multiples