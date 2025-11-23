class Solution:
    def sortArrayByParityII(self, nums: List[int]) -> List[int]:
        even_index = 0
        odd_index = 1
        n = len(nums)
        while even_index < n and odd_index < n:
            while even_index < n and nums[even_index] % 2 == 0:
                even_index += 2
            while odd_index < n and nums[odd_index] % 2 != 0:
                odd_index += 2
            if even_index < n and odd_index < n:
                nums[even_index], nums[odd_index] = nums[odd_index], nums[even_index]
                even_index += 2
                odd_index += 2
        return nums