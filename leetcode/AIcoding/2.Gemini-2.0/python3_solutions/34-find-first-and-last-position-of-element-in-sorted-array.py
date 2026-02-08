class Solution:
    def searchRange(self, nums: list[int], target: int) -> list[int]:
        def find_first(nums, target):
            left, right = 0, len(nums) - 1
            index = -1
            while left <= right:
                mid = (left + right) // 2
                if nums[mid] >= target:
                    right = mid - 1
                else:
                    left = mid + 1
                if nums[mid] == target:
                    index = mid
            return index

        def find_last(nums, target):
            left, right = 0, len(nums) - 1
            index = -1
            while left <= right:
                mid = (left + right) // 2
                if nums[mid] <= target:
                    left = mid + 1
                else:
                    right = mid - 1
                if nums[mid] == target:
                    index = mid
            return index

        first = find_first(nums, target)
        last = find_last(nums, target)
        return [first, last]