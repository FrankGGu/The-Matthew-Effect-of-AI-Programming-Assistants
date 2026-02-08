class FenwickTree:
    def __init__(self, size):
        self.tree = [0] * (size + 1)
        self.size = size

    def update(self, idx, delta):
        while idx <= self.size:
            self.tree[idx] += delta
            idx += idx & (-idx)

    def query(self, idx):
        s = 0
        while idx > 0:
            s += self.tree[idx]
            idx -= idx & (-idx)
        return s

class Solution:
    def createSortedArray(self, instructions: list[int]) -> int:
        max_val = 100000
        ft = FenwickTree(max_val)
        total_cost = 0
        MOD = 10**9 + 7

        for i, num in enumerate(instructions):
            # Count elements strictly less than num
            count_less = ft.query(num - 1)

            # Count elements strictly greater than num
            # 'i' is the number of elements already inserted into the array.
            # ft.query(num) gives the count of elements <= num.
            # So, i - ft.query(num) gives the count of elements > num.
            count_greater = i - ft.query(num)

            total_cost = (total_cost + min(count_less, count_greater)) % MOD

            ft.update(num, 1)

        return total_cost