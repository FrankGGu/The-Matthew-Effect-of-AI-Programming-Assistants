class Solution:
    def numSubarrayBoundedMax(self, nums: list[int], left: int, right: int) -> int:

        def count_subarrays_with_max_at_most_k(arr, k):
            count = 0
            current_valid_length = 0
            for x in arr:
                if x <= k:
                    current_valid_length += 1
                else:
                    count += current_valid_length * (current_valid_length + 1) // 2
                    current_valid_length = 0
            count += current_valid_length * (current_valid_length + 1) // 2
            return count

        return count_subarrays_with_max_at_most_k(nums, right) - count_subarrays_with_max_at_most_k(nums, left - 1)