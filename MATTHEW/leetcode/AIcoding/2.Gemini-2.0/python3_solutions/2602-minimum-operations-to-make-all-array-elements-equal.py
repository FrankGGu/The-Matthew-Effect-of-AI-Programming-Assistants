from typing import List

class Solution:
    def minOperations(self, nums: List[int], queries: List[int]) -> List[int]:
        nums.sort()
        prefix_sum = [0] * (len(nums) + 1)
        for i in range(len(nums)):
            prefix_sum[i + 1] = prefix_sum[i] + nums[i]

        result = []
        for query in queries:
            left, right = 0, len(nums) - 1
            while left <= right:
                mid = (left + right) // 2
                if nums[mid] < query:
                    left = mid + 1
                else:
                    right = mid - 1

            smaller_count = left
            larger_count = len(nums) - left

            smaller_sum = prefix_sum[left]
            larger_sum = prefix_sum[len(nums)] - prefix_sum[left]

            operations = (query * smaller_count - smaller_sum) + (larger_sum - query * larger_count)
            result.append(operations)

        return result