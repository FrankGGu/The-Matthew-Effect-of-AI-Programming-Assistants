class FenwickTree:
    def __init__(self, size):
        self.size = size
        self.tree = [0] * (self.size + 1)

    def update(self, index, delta=1):
        while index <= self.size:
            self.tree[index] += delta
            index += index & -index

    def query(self, index):
        res = 0
        while index > 0:
            res += self.tree[index]
            index -= index & -index
        return res

class Solution:
    def createSortedArray(self, instructions: List[int]) -> int:
        max_val = max(instructions)
        ft = FenwickTree(max_val)
        res = 0
        mod = 10**9 + 7

        for i, num in enumerate(instructions):
            less = ft.query(num - 1)
            greater = i - ft.query(num)
            res += min(less, greater)
            res %= mod
            ft.update(num)

        return res