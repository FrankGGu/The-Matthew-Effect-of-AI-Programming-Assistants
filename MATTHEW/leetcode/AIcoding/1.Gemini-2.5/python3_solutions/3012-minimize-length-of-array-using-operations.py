import math

class Solution:
    def minimizeLength(self, nums: list[int]) -> int:
        if not nums:
            return 0
        if len(nums) == 1:
            return 1

        # Step 1: Find the minimum element in the array
        min_val = nums[0]
        for num in nums:
            if num < min_val:
                min_val = num

        # Step 2: Check if all elements are multiples of min_val
        # If any element 'x' is found such that 'x % min_val != 0',
        # it means we can perform the operation (x, min_val) -> x % min_val.
        # The result 'x % min_val' will be strictly smaller than 'min_val'.
        # This implies that we can always reduce the minimum value in the array.
        # This process continues until the minimum value 'm_final' divides all
        # other elements in the array. This 'm_final' will be the greatest
        # common divisor (GCD) of all initial numbers.
        # Once we reach a state where all elements are multiples of 'm_final',
        # we can then pair any element 'x' with 'm_final' (x % m_final == 0)
        # to remove both, reducing the array length by 2.
        # This allows us to reduce the array to a single element 'm_final'.
        # Thus, if there's any element not a multiple of 'min_val', the minimum length is 1.

        # If all elements are multiples of 'min_val', we cannot produce an
        # element smaller than 'min_val'. Any operation (x, y) where x, y
        # are multiples of 'min_val' will result in a value that is also
        # a multiple of 'min_val'. Specifically, we can always choose x and
        # y such that y = min_val, and x % min_val == 0. This reduces the
        # length by 2. We can continue this until 0 or 1 element remains.
        # Thus, if all elements are multiples of 'min_val', the minimum length is len(nums) % 2.

        has_non_multiple = False
        for num in nums:
            if num % min_val != 0:
                has_non_multiple = True
                break

        if has_non_multiple:
            return 1
        else:
            return len(nums) % 2