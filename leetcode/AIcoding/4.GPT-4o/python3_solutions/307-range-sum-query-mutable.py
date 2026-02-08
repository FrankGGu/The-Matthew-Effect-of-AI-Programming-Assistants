class NumArray:

    def __init__(self, nums: List[int]):
        self.nums = nums
        self.n = len(nums)
        self.tree = [0] * (self.n + 1)
        for i in range(self.n):
            self.update(i, nums[i])

    def update(self, index: int, val: int) -> None:
        diff = val - self.nums[index]
        self.nums[index] = val
        index += 1
        while index <= self.n:
            self.tree[index] += diff
            index += index & -index

    def sumRange(self, left: int, right: int) -> int:
        return self.get_sum(right) - self.get_sum(left - 1)

    def get_sum(self, index: int) -> int:
        index += 1
        total = 0
        while index > 0:
            total += self.tree[index]
            index -= index & -index
        return total