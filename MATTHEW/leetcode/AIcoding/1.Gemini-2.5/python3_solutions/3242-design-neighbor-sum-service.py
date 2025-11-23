from typing import List

class NeighborSumService:

    def __init__(self, nums: List[int]):
        self.nums = list(nums)

    def update(self, index: int, val: int) -> None:
        if 0 <= index < len(self.nums):
            self.nums[index] = val

    def query(self, index: int) -> int:
        n = len(self.nums)
        if n == 0 or index < 0 or index >= n:
            return 0

        neighbor_sum = 0
        if index > 0:
            neighbor_sum += self.nums[index - 1]
        if index < n - 1:
            neighbor_sum += self.nums[index + 1]

        return neighbor_sum