class Solution:
    def peakIndexInMountainArray(self, arr: list[int]) -> int:
        left, right = 0, len(arr) - 1

        while left < right:
            mid = left + (right - left) // 2
            if arr[mid] < arr[mid + 1]:
                # We are on the increasing slope, peak is to the right
                left = mid + 1
            else:
                # We are on the decreasing slope or at the peak, peak is at or to the left of mid
                right = mid

        return left