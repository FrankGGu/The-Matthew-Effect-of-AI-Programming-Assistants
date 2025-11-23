from collections import defaultdict

class Solution:
    def findMaximumSubsetSum(self, nums, k):
        pass

    def maximumSubarraySum(self, nums, k):
        n = len(nums)
        freq = defaultdict(int)
        current_sum = 0
        max_sum = 0
        unique_count = 0

        for i in range(n):
            if freq[nums[i]] == 0:
                unique_count += 1
            freq[nums[i]] += 1
            current_sum += nums[i]

            if i >= k:
                left = nums[i - k]
                freq[left] -= 1
                if freq[left] == 0:
                    unique_count -= 1
                current_sum -= left

            if i >= k - 1:
                if unique_count == k:
                    max_sum = max(max_sum, current_sum)

        return max_sum