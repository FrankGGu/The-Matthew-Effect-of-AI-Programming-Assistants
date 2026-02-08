class Solution:
    def searchRange(self, nums: list[int], target: int) -> list[int]:
        def find_first(arr, t):
            low, high = 0, len(arr) - 1
            first_pos = -1
            while low <= high:
                mid = low + (high - low) // 2
                if arr[mid] == t:
                    first_pos = mid
                    high = mid - 1
                elif arr[mid] < t:
                    low = mid + 1
                else:
                    high = mid - 1
            return first_pos

        def find_last(arr, t):
            low, high = 0, len(arr) - 1
            last_pos = -1
            while low <= high:
                mid = low + (high - low) // 2
                if arr[mid] == t:
                    last_pos = mid
                    low = mid + 1
                elif arr[mid] < t:
                    low = mid + 1
                else:
                    high = mid - 1
            return last_pos

        first = find_first(nums, target)
        last = find_last(nums, target)

        return [first, last]