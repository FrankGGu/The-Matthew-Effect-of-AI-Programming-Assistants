class Solution:
    def minMaxGame(self, nums: List[int]) -> int:
        n = len(nums)
        while n > 1:
            new_nums = []
            for i in range(n // 2):
                if i % 2 == 0:
                    new_nums.append(min(nums[2 * i], nums[2 * i + 1]))
                else:
                    new_nums.append(max(nums[2 * i], nums[2 * i + 1]))
            nums = new_nums
            n = len(nums)
        return nums[0]