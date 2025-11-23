class Solution:
    def minSwaps(self, nums: List[int]) -> int:
        ones = nums.count(1)
        n = len(nums)
        if ones == 0 or ones == n:
            return 0

        window = nums[:ones].count(0)
        min_swaps = window
        for i in range(ones, n + ones):
            left = i - ones
            if nums[left % n] == 0:
                window -= 1
            if nums[i % n] == 0:
                window += 1
            min_swaps = min(min_swaps, window)

        return min_swaps