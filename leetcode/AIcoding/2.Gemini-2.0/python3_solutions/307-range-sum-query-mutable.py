class NumArray:

    def __init__(self, nums):
        self.nums = nums
        self.n = len(nums)
        self.bit = [0] * (self.n + 1)
        for i in range(self.n):
            self.update_bit(i, nums[i])

    def update_bit(self, i, val):
        i += 1
        while i <= self.n:
            self.bit[i] += val
            i += i & (-i)

    def sum_range_bit(self, i):
        i += 1
        res = 0
        while i > 0:
            res += self.bit[i]
            i -= i & (-i)
        return res

    def update(self, index, val):
        diff = val - self.nums[index]
        self.nums[index] = val
        self.update_bit(index, diff)

    def sumRange(self, left, right):
        return self.sum_range_bit(right) - self.sum_range_bit(left - 1)