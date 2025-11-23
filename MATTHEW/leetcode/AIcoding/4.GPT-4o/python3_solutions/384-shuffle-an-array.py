import random

class Solution:

    def __init__(self, nums: List[int]):
        self.original = nums[:]
        self.nums = nums

    def reset(self) -> List[int]:
        self.nums = self.original[:]
        return self.nums

    def shuffle(self) -> List[int]:
        random.shuffle(self.nums)
        return self.nums