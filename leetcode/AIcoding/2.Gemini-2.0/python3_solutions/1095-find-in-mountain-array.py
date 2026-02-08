class Solution:
    def findInMountainArray(self, target: int, mountain_arr: 'MountainArray') -> int:
        n = mountain_arr.length()

        def find_peak_index(l, r):
            while l < r:
                mid = (l + r) // 2
                if mountain_arr.get(mid) < mountain_arr.get(mid + 1):
                    l = mid + 1
                else:
                    r = mid
            return l

        def binary_search_ascending(l, r, target):
            while l <= r:
                mid = (l + r) // 2
                val = mountain_arr.get(mid)
                if val == target:
                    return mid
                elif val < target:
                    l = mid + 1
                else:
                    r = mid - 1
            return -1

        def binary_search_descending(l, r, target):
            while l <= r:
                mid = (l + r) // 2
                val = mountain_arr.get(mid)
                if val == target:
                    return mid
                elif val < target:
                    r = mid - 1
                else:
                    l = mid + 1
            return -1

        peak_index = find_peak_index(0, n - 1)
        index = binary_search_ascending(0, peak_index, target)
        if index != -1:
            return index
        return binary_search_descending(peak_index + 1, n - 1, target)