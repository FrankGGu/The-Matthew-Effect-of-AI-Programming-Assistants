class Solution:
    def countFairPairs(self, nums: List[int], low: int, high: int) -> int:
        nums.sort()
        n = len(nums)
        count = 0
        for i in range(n):
            left = i + 1
            right = n - 1
            while left <= right:
                mid = (left + right) // 2
                if nums[i] + nums[mid] < low:
                    left = mid + 1
                else:
                    right = mid - 1
            l = left
            left = i + 1
            right = n - 1
            while left <= right:
                mid = (left + right) // 2
                if nums[i] + nums[mid] > high:
                    right = mid - 1
                else:
                    left = mid + 1
            r = right
            count += max(0, r - l + 1)
        return count