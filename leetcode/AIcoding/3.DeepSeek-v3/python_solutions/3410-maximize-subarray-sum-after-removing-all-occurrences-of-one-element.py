class Solution:
    def maximumSum(self, nums: List[int]) -> int:
        from collections import defaultdict

        num_indices = defaultdict(list)
        for idx, num in enumerate(nums):
            num_indices[num].append(idx)

        max_sum = -float('inf')

        for num in num_indices:
            indices = num_indices[num]
            current_sum = 0
            max_current = -float('inf')

            for i in range(len(nums)):
                if nums[i] == num:
                    continue
                current_sum += nums[i]
                if current_sum > max_current:
                    max_current = current_sum
                if current_sum < 0:
                    current_sum = 0

            if max_current > max_sum:
                max_sum = max_current

        return max_sum if max_sum != -float('inf') else max(nums)