class Solution:
    def countSubarrays(self, nums: list[int], k: int) -> int:
        max_val = max(nums)
        n = len(nums)
        count = 0
        for i in range(n):
            max_count = 0
            for j in range(i, n):
                if nums[j] == max_val:
                    max_count += 1
                if max_count >= k:
                    count += (n - j)
                    break
        return count