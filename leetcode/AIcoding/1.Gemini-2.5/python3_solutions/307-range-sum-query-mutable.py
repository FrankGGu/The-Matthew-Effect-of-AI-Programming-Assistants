from typing import List

class NumArray:

    def __init__(self, nums: List[int]):
        self.n = len(nums)
        self.nums = nums
        self.tree = [0] * (4 * self.n)

        if self.n > 0:
            self._build(0, 0, self.n - 1)

    def _build(self, tree_idx: int, low: int, high: int):
        if low == high:
            self.tree[tree_idx] = self.nums[low]
            return

        mid = (low + high) // 2
        self._build(2 * tree_idx + 1, low, mid)
        self._build(2 * tree_idx + 2, mid + 1, high)
        self.tree[tree_idx] = self.tree[2 * tree_idx + 1] + self.tree[2 * tree_idx + 2]

    def update(self, index: int, val: int) -> None:
        self.nums[index] = val
        self._update(0, 0, self.n - 1, index, val)

    def _update(self, tree_idx: int, low: int, high: int, arr_idx: int, val: int):
        if low == high:
            self.tree[tree_idx] = val
            return

        mid = (low + high) // 2
        if low <= arr_idx <= mid:
            self._update(2 * tree_idx + 1, low, mid, arr_idx, val)
        else:
            self._update(2 * tree_idx + 2, mid + 1, high, arr_idx, val)

        self.tree[tree_idx] = self.tree[2 * tree_idx + 1] + self.tree[2 * tree_idx + 2]

    def sumRange(self, left: int, right: int) -> int:
        return self._query(0, 0, self.n - 1, left, right)

    def _query(self, tree_idx: int, low: int, high: int, query_low: int, query_high: int) -> int:
        if high < query_low or low > query_high:
            return 0

        if query_low <= low and high <= query_high:
            return self.tree[tree_idx]

        mid = (low + high) // 2
        left_sum = self._query(2 * tree_idx + 1, low, mid, query_low, query_high)
        right_sum = self._query(2 * tree_idx + 2, mid + 1, high, query_low, query_high)
        return left_sum + right_sum