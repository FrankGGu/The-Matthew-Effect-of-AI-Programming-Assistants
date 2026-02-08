class Solution:
    def countSubarrays(self, nums: List[int], minK: int, maxK: int) -> int:
        res = 0
        min_pos = -1
        max_pos = -1
        left_bound = -1

        for i, num in enumerate(nums):
            if num < minK or num > maxK:
                left_bound = i
                min_pos = -1
                max_pos = -1
                continue

            if num == minK:
                min_pos = i
            if num == maxK:
                max_pos = i

            if min_pos != -1 and max_pos != -1:
                res += min(min_pos, max_pos) - left_bound

        return res