class Solution:
    def wiggleSort(self, nums: list[int]) -> None:
        """
        Do not return anything, modify nums in-place instead.
        """
        n = len(nums)

        # Step 1: Sort the array
        # This takes O(N log N) time and O(N) space (for the copy in Python's sorted())
        sorted_nums = sorted(nums)

        # Step 2: Distribute elements into the original array
        # We want to achieve nums[0] < nums[1] > nums[2] < nums[3] ...
        # This pattern means: small, LARGE, small, LARGE, ...
        # So, elements at even indices (0, 2, 4, ...) should be from the smaller half.
        # Elements at odd indices (1, 3, 5, ...) should be from the larger half.

        # Pointers for the sorted_nums array:
        # 'small_ptr' starts at the largest element of the first half (or first half + middle if n is odd).
        # 'large_ptr' starts at the largest element of the second half (or largest overall).

        # For n=6, (n-1)//2 = 2. sorted_nums indices: [0, 1, 2, 3, 4, 5]
        # small_ptr starts at 2 (index of the 3rd smallest element)
        # large_ptr starts at 5 (index of the largest element)

        # For n=5, (n-1)//2 = 2. sorted_nums indices: [0, 1, 2, 3, 4]
        # small_ptr starts at 2 (index of the 3rd smallest element)
        # large_ptr starts at 4 (index of the largest element)

        small_ptr = (n - 1) // 2
        large_ptr = n - 1

        # Create a temporary array to store the result.
        # This is necessary because directly writing to 'nums' while reading from 'sorted_nums'
        # (which is a copy of original 'nums') could lead to overwriting elements
        # that are still needed for placement.
        result = [0] * n

        for i in range(n):
            if i % 2 == 0:  # Even index (0, 2, 4, ...), place a smaller element
                result[i] = sorted_nums[small_ptr]
                small_ptr -= 1
            else:  # Odd index (1, 3, 5, ...), place a larger element
                result[i] = sorted_nums[large_ptr]
                large_ptr -= 1

        # Copy the elements from the temporary 'result' array back to 'nums'.
        # This modifies 'nums' in-place as required by the problem.
        nums[:] = result