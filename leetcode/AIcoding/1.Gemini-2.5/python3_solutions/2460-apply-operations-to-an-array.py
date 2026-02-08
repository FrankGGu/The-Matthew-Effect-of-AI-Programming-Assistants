class Solution:
    def applyOperations(self, nums: list[int]) -> list[int]:
        n = len(nums)

        # Step 1: Apply operations
        for i in range(n - 1):
            if nums[i] == nums[i+1]:
                nums[i] *= 2
                nums[i+1] = 0

        # Step 2: Move all non-zero elements to the beginning
        write_idx = 0
        for read_idx in range(n):
            if nums[read_idx] != 0:
                nums[write_idx] = nums[read_idx]
                write_idx += 1

        # Fill the remaining elements with zeros
        for i in range(write_idx, n):
            nums[i] = 0

        return nums