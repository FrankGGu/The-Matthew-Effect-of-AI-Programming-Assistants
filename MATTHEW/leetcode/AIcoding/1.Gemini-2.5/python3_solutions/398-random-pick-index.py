import random

class Solution:

    def __init__(self, nums: list[int]):
        self.nums = nums

    def pick(self, target: int) -> int:
        count = 0
        result_index = -1
        for i, num in enumerate(self.nums):
            if num == target:
                count += 1
                if random.randrange(count) == 0:
                    result_index = i
        return result_index