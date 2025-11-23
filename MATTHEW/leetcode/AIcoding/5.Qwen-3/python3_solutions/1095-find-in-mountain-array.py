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

        def binary_search(left, right, target, ascending=True):
            while left <= right:
                mid = (left + right) // 2
                val = mountain_arr.get(mid)
                if val == target:
                    return mid
                if ascending:
                    if val < target:
                        left = mid + 1
                    else:
                        right = mid - 1
                else:
                    if val > target:
                        left = mid + 1
                    else:
                        right = mid - 1
            return -1

        peak = find_peak()
        res = binary_search(0, peak, target, True)
        if res != -1:
            return res
        return binary_search(peak, mountain_arr.length() - 1, target, False)