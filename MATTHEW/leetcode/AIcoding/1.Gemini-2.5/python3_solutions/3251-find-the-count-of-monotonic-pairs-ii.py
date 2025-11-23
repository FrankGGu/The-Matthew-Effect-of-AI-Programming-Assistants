class FenwickTree:
    def __init__(self, size):
        self.tree = [0] * (size + 1)
        self.size = size

    def update(self, index, delta):
        index += 1
        while index <= self.size:
            self.tree[index] += delta
            index += index & (-index)

    def query(self, index):
        index += 1
        s = 0
        while index > 0:
            s += self.tree[index]
            index -= index & (-index)
        return s

class Solution:
    def findTheCountOfMonotonicPairsII(self, nums: list[int]) -> int:
        n = len(nums)
        if n < 2:
            return 0

        sorted_unique_nums = sorted(list(set(nums)))
        val_to_rank = {val: i for i, val in enumerate(sorted_unique_nums)}

        compressed_nums = [val_to_rank[num] for num in nums]

        max_rank = len(sorted_unique_nums)

        bit = FenwickTree(max_rank)

        count = 0

        for i in range(n - 1, -1, -1):
            current_rank = compressed_nums[i]

            count += bit.query(max_rank - 1) - bit.query(current_rank - 1)

            bit.update(current_rank, 1)

        return count