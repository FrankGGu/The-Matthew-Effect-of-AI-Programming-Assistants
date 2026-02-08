import random

class Solution:

    def __init__(self, nums: list[int]):
        self.original_nums = list(nums)
        self.current_nums = list(nums)

    def reset(self) -> list[int]:
        self.current_nums = list(self.original_nums)
        return self.original_nums

    def shuffle(self) -> list[int]:
        n = len(self.current_nums)
        for i in range(n):
            j = random.randrange(i, n)
            self.current_nums[i], self.current_nums[j] = self.current_nums[j], self.current_nums[i]
        return self.current_nums