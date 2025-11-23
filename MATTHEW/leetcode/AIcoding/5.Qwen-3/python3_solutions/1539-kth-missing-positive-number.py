class Solution:
    def findKthMissingPositive(self, nums: List[int], k: int) -> int:
        left, right = 0, len(nums)
        while left < right:
            mid = (left + right) // 2
            if nums[mid] - mid - 1 < k:
                left = mid + 1
            else:
                right = mid
        return left + k