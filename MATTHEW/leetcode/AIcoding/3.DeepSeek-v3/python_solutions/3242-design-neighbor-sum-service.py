class NeighborSumService:
    def __init__(self, nums):
        self.nums = nums
        self.prefix = [0] * (len(nums) + 1)
        for i in range(len(nums)):
            self.prefix[i+1] = self.prefix[i] + nums[i]

    def update(self, index: int, val: int) -> None:
        diff = val - self.nums[index]
        self.nums[index] = val
        for i in range(index + 1, len(self.prefix)):
            self.prefix[i] += diff

    def sum(self, start: int, end: int) -> int:
        return self.prefix[end] - self.prefix[start]