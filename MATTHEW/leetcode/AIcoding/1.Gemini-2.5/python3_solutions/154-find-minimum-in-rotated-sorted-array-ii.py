class Solution:
    def findMin(self, nums: list[int]) -> int:
        low = 0
        high = len(nums) - 1

        while low < high:
            mid = low + (high - low) // 2

            if nums[mid] < nums[high]:
                # The right part is sorted, or mid is the minimum.
                # The minimum must be in the left half including mid.
                high = mid
            elif nums[mid] > nums[high]:
                # The minimum must be in the right half (mid+1 to high).
                low = mid + 1
            else:
                # nums[mid] == nums[high]. We can't decide which half to discard.
                # For example, [1,1,1,0,1] or [1,0,1,1,1].
                # Safely reduce the search space by discarding high.
                # The minimum could be nums[high] itself, but if it is,
                # nums[mid] is also that value, so we don't lose it.
                high -= 1

        return nums[low]