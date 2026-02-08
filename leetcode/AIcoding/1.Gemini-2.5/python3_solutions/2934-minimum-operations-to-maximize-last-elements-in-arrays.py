import math

class Solution:
    def minOperations(self, nums1: list[int], nums2: list[int]) -> int:
        n = len(nums1)

        def calculate_ops(target_val1: int, target_val2: int, initial_ops_count: int) -> int:
            current_ops = initial_ops_count
            for i in range(n - 1):
                # Check if elements at index i satisfy conditions without swapping
                if nums1[i] <= target_val1 and nums2[i] <= target_val2:
                    continue
                # Check if elements at index i satisfy conditions by swapping them
                elif nums2[i] <= target_val1 and nums1[i] <= target_val2:
                    current_ops += 1
                else:
                    # Impossible to satisfy conditions for this pair
                    return math.inf
            return current_ops

        # Scenario 1: Do not swap the last elements (nums1[n-1], nums2[n-1])
        # The target values for all other elements will be nums1[n-1] and nums2[n-1] respectively.
        ops_scenario1 = calculate_ops(nums1[n-1], nums2[n-1], 0)

        # Scenario 2: Swap the last elements (nums1[n-1], nums2[n-1])
        # This costs 1 operation.
        # The target values for all other elements will be nums2[n-1] and nums1[n-1] respectively.
        ops_scenario2 = calculate_ops(nums2[n-1], nums1[n-1], 1)

        # The minimum operations is the minimum of the two scenarios
        result = min(ops_scenario1, ops_scenario2)

        # If it's impossible for both scenarios, return -1
        if result == math.inf:
            return -1
        else:
            return result