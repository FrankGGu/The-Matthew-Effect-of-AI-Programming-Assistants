class Solution:
    def searchRange(self, nums: List[int], target: int) -> List[int]:
        def find_left(nums, target):
            left, right = 0, len(nums) - 1
            res = -1
            while left <= right:
                mid = left + (right - left) // 2
                if nums[mid] >= target:
                    right = mid - 1
                else:
                    left = mid + 1
                if nums[mid] == target:
                    res = mid
            return res

        def find_right(nums, target):
            left, right = 0, len(nums) - 1
            res = -1
            while left <= right:
                mid = left + (right - left) // 2
                if nums[mid] <= target:
                    left = mid + 1
                else:
                    right = mid - 1
                if nums[mid] == target:
                    res = mid
            return res

        left_pos = find_left(nums, target)
        right_pos = find_right(nums, target)
        return [left_pos, right_pos]