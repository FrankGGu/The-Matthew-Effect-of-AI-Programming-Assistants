import random
from typing import List

class Solution:

    def __init__(self, nums: List[int]):
        self.nums = nums.copy()

    def reset(self) -> List[int]:
        return self.nums

    def shuffle(self) -> List[int]:
        shuffled = self.nums.copy()
        random.shuffle(shuffled)
        return shuffled