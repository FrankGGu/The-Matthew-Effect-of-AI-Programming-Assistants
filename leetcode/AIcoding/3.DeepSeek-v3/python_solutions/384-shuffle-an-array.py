import random

class Solution:

    def __init__(self, nums: List[int]):
        self.original = nums.copy()
        self.array = nums.copy()

    def reset(self) -> List[int]:
        self.array = self.original.copy()
        return self.array

    def shuffle(self) -> List[int]:
        shuffled = self.array.copy()
        for i in range(len(shuffled)):
            j = random.randint(i, len(shuffled) - 1)
            shuffled[i], shuffled[j] = shuffled[j], shuffled[i]
        self.array = shuffled
        return self.array