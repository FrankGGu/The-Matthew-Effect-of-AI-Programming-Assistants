class Solution:
    def findInMountainArray(self, target: int, mountain_arr: 'MountainArray') -> int:
        length = mountain_arr.length()

        # Step 1: Find the peak index
        low, high = 0, length - 1
        while low < high:
            mid = low + (high - low) // 2
            if mountain_arr.get(mid) < mountain_arr.get(mid + 1):
                # We are on the increasing slope, peak is to the right
                low = mid + 1
            else:
                # We are on the decreasing slope or at the peak, peak is at or to the left
                high = mid
        peak_index = low # At the end of the loop, low == high == peak_index

        # Step 2: Search in the increasing part (left of the peak, including peak)
        low, high = 0, peak_index
        while low <= high:
            mid = low + (high - low) // 2
            val = mountain_arr.get(mid)
            if val == target:
                return mid
            elif val < target:
                low = mid + 1
            else:
                high = mid - 1

        # Step 3: Search in the decreasing part (right of the peak)
        low, high = peak_index + 1, length - 1
        while low <= high:
            mid = low + (high - low) // 2
            val = mountain_arr.get(mid)
            if val == target:
                return mid
            elif val < target: # In a decreasing array, if current value is less than target, target must be to the left (smaller index)
                high = mid - 1
            else: # If current value is greater than target, target must be to the right (larger index)
                low = mid + 1

        return -1