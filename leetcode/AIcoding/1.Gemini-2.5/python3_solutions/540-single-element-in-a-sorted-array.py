class Solution:
    def singleNonDuplicate(self, nums: list[int]) -> int:
        low = 0
        high = len(nums) - 1

        while low < high:
            mid = (low + high) // 2

            if mid % 2 == 0:  # mid is even
                if nums[mid] == nums[mid + 1]:
                    # The pair is at (mid, mid+1), so the single element is to the right
                    low = mid + 2
                else:
                    # nums[mid] is either the single element or the second element of a pair
                    # The single element is at or to the left of mid
                    high = mid
            else:  # mid is odd
                if nums[mid] == nums[mid - 1]:
                    # The pair is at (mid-1, mid), so the single element is to the right
                    low = mid + 1
                else:
                    # nums[mid] is either the single element or the first element of a pair
                    # The single element is at or to the left of mid
                    high = mid

        return nums[low]