class Solution:
    def countSubarrays(self, nums: list[int], minK: int, maxK: int) -> int:
        ans = 0
        last_invalid_idx = -1
        last_mink_idx = -1
        last_maxk_idx = -1

        for i, num in enumerate(nums):
            if not (minK <= num <= maxK):
                last_invalid_idx = i

            if num == minK:
                last_mink_idx = i

            if num == maxK:
                last_maxk_idx = i

            ans += max(0, min(last_mink_idx, last_maxk_idx) - last_invalid_idx)

        return ans