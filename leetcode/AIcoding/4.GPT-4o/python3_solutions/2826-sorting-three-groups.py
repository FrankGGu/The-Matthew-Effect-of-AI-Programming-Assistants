class Solution:
    def sortColors(self, nums: List[int]) -> None:
        zero_index, current_index, two_index = 0, 0, len(nums) - 1

        while current_index <= two_index:
            if nums[current_index] == 0:
                nums[zero_index], nums[current_index] = nums[current_index], nums[zero_index]
                zero_index += 1
                current_index += 1
            elif nums[current_index] == 1:
                current_index += 1
            else:
                nums[current_index], nums[two_index] = nums[two_index], nums[current_index]
                two_index -= 1