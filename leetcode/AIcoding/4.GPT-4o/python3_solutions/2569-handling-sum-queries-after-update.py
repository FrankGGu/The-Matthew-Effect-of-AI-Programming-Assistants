class NumArray:

    def __init__(self, nums: List[int]):
        self.nums = nums
        self.prefix_sum = [0] * (len(nums) + 1)
        for i in range(1, len(nums) + 1):
            self.prefix_sum[i] = self.prefix_sum[i - 1] + nums[i - 1]

    def update(self, index: int, val: int) -> None:
        diff = val - self.nums[index]
        self.nums[index] = val
        for i in range(index + 1, len(self.prefix_sum)):
            self.prefix_sum[i] += diff

    def sumRange(self, left: int, right: int) -> int:
        return self.prefix_sum[right + 1] - self.prefix_sum[left]