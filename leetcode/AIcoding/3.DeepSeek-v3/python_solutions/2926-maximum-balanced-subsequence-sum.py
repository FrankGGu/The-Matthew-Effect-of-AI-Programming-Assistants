import bisect

class Solution:
    def maxBalancedSubsequenceSum(self, nums: List[int]) -> int:
        n = len(nums)
        keys = sorted(set(num - i for i, num in enumerate(nums)))
        tree = FenwickTree(len(keys))

        max_sum = -float('inf')
        for i in range(n):
            val = nums[i]
            idx = bisect.bisect_right(keys, val - i) - 1
            current_max = tree.query(idx)
            if current_max > 0:
                val += current_max
            tree.update(idx, val)
            max_sum = max(max_sum, val)

        return max_sum

class FenwickTree:
    def __init__(self, size):
        self.size = size
        self.tree = [-float('inf')] * (self.size + 1)

    def update(self, index, value):
        index += 1
        while index <= self.size:
            if self.tree[index] < value:
                self.tree[index] = value
            else:
                break
            index += index & -index

    def query(self, index):
        index += 1
        res = -float('inf')
        while index > 0:
            if self.tree[index] > res:
                res = self.tree[index]
            index -= index & -index
        return res