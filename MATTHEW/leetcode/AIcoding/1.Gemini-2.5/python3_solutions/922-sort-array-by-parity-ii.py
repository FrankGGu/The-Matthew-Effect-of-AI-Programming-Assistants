class Solution:
    def sortArrayByParityII(self, nums: list[int]) -> list[int]:
        n = len(nums)
        j = 1

        for i in range(0, n, 2):
            if nums[i] % 2 != 0:
                while nums[j] % 2 != 0:
                    j += 2
                nums[i], nums[j] = nums[j], nums[i]

        return nums