class Solution:
    def checkArray(self, nums: list[int]) -> bool:
        n = len(nums)

        # If the array has only one element, it must be zero
        if n == 1:
            return nums[0] == 0

        # Iterate through the array from left to right, up to the second-to-last element
        # The operation is assumed to be: choose an index i and a positive integer x,
        # subtract x from nums[i] and nums[i+1].
        # All elements must remain non-negative throughout the process.
        for i in range(n - 1):
            # If nums[i] is already negative, it's impossible to make it zero
            # by subtracting a positive x from it (as we can only decrease values).
            # This implies a previous operation made it negative, or it was initially negative.
            # In either case, it's impossible.
            if nums[i] < 0:
                return False

            # If nums[i] is positive, we must perform an operation at index i
            # to make nums[i] zero. The value to subtract is nums[i] itself.
            if nums[i] > 0:
                x = nums[i]
                # Check if nums[i+1] can sustain the subtraction without becoming negative.
                if nums[i+1] < x:
                    return False

                # Perform the operation: subtract x from nums[i+1].
                # nums[i] conceptually becomes 0, but we don't need to update it
                # in the array because we won't look at nums[i] again.
                nums[i+1] -= x

        # After the loop, all elements from index 0 to n-2 have been processed
        # and are effectively zero (or were already zero).
        # We only need to check if the last element is zero.
        return nums[n-1] == 0