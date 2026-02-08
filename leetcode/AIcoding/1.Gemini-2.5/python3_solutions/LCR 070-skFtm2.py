class Solution:
    def singleNonDuplicate(self, nums: list[int]) -> int:
        low = 0
        high = len(nums) - 1

        while low < high:
            mid = (low + high) // 2

            # Ensure mid is always the start of a potential pair (even index)
            # If mid is odd, decrement it to make it even.
            # This simplifies the comparison logic to always check nums[mid] and nums[mid+1].
            if mid % 2 == 1:
                mid -= 1

            # Now mid is guaranteed to be an even index.
            # Check if nums[mid] and nums[mid+1] form a pair.
            if nums[mid] == nums[mid + 1]:
                # If they are equal, the single element must be to the right of this pair.
                # Discard both elements of the pair.
                low = mid + 2
            else:
                # If they are not equal, the single element is at or to the left of mid.
                # It could be nums[mid] itself, or further left.
                # The search space includes mid.
                high = mid

        # When low == high, we have found the single element.
        return nums[low]