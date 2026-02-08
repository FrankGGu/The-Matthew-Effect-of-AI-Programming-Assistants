import random

class Solution:

    def __init__(self, nums: list[int]):
        self.nums = nums

    def pick(self, target: int) -> int:
        indices = [i for i, num in enumerate(self.nums) if num == target]
        return random.choice(indices)