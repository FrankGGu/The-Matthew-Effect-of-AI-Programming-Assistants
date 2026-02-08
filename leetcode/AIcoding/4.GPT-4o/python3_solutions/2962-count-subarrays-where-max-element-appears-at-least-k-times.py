class Solution:
    def countSubarrays(self, nums: List[int], k: int) -> int:
        from collections import defaultdict

        n = len(nums)
        count = 0
        for max_elem in set(nums):
            if nums.count(max_elem) < k:
                continue
            left = 0
            total = 0
            for right in range(n):
                if nums[right] == max_elem:
                    total += right - left + 1
                else:
                    while left <= right and nums[left] != max_elem:
                        left += 1
                    if left <= right:
                        total += right - left + 1
                        left += 1
            count += total
        return count