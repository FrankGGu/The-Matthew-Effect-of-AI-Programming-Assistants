class Solution:
    def maximumSegmentSum(self, nums: List[int], remove: List[int]) -> int:
        n = len(nums)
        removed = [False] * n
        for r in remove:
            removed[r] = True

        max_sum = 0
        current_sum = 0
        for i in range(n):
            if removed[i]:
                max_sum = max(max_sum, current_sum)
                current_sum = 0
            else:
                current_sum += nums[i]

        max_sum = max(max_sum, current_sum)
        return max_sum