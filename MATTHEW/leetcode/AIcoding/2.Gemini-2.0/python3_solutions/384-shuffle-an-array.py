import random

class Solution:

    def __init__(self, nums: list[int]):
        self.nums = nums
        self.original = nums[:]

    def reset(self) -> list[int]:
        self.nums = self.original[:]
        return self.nums

    def shuffle(self) -> list[int]:
        for i in range(len(self.nums)):
            j = random.randrange(i, len(self.nums))
            self.nums[i], self.nums[j] = self.nums[j], self.nums[i]
        return self.nums