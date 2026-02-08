class Solution:
    def moveZeroes(self, nums: list[int]) -> None:
        """
        Do not return anything, modify nums in-place instead.
        """
        write_ptr = 0

        for read_ptr in range(len(nums)):
            if nums[read_ptr] != 0:
                nums[write_ptr] = nums[read_ptr]
                write_ptr += 1

        for i in range(write_ptr, len(nums)):
            nums[i] = 0