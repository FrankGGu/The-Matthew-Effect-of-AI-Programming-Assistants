class Solution:
    def findInMountainArray(self, target: int, mountain_arr: 'MountainArray') -> int:
        def find_peak():
            left, right = 0, mountain_arr.length() - 1
            while left < right:
                mid = (left + right) // 2
                if mountain_arr.get(mid) < mountain_arr.get(mid + 1):
                    left = mid + 1
                else:
                    right = mid
            return left

        def binary_search(left, right, target, asc=True):
            while left <= right:
                mid = (left + right) // 2
                mid_val = mountain_arr.get(mid)
                if mid_val == target:
                    return mid
                if asc:
                    if mid_val < target:
                        left = mid + 1
                    else:
                        right = mid - 1
                else:
                    if mid_val > target:
                        left = mid + 1
                    else:
                        right = mid - 1
            return -1

        peak = find_peak()
        result = binary_search(0, peak, target, True)
        if result != -1:
            return result
        return binary_search(peak + 1, mountain_arr.length() - 1, target, False)