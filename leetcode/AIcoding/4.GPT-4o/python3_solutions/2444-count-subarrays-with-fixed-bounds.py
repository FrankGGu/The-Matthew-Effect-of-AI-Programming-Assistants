class Solution:
    def countSubarrays(self, nums: List[int], minK: int, maxK: int) -> int:
        count = 0
        start = 0
        last_min = -1
        last_max = -1

        for i, num in enumerate(nums):
            if num < minK or num > maxK:
                start = i + 1
            if num == minK:
                last_min = i
            if num == maxK:
                last_max = i

            count += max(0, min(last_min, last_max) - start + 1)

        return count