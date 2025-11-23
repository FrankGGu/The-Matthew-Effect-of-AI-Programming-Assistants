class Solution:
    def monotonicPairs(self, nums: List[int]) -> int:
        n = len(nums)
        count = 0

        # Count increasing pairs
        for i in range(n):
            for j in range(i + 1, n):
                if nums[i] <= nums[j]:
                    count += 1

        # Count decreasing pairs
        for i in range(n):
            for j in range(i + 1, n):
                if nums[i] >= nums[j]:
                    count += 1

        return count