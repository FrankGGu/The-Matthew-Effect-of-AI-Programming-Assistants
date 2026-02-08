class Solution:
    def createSortedArray(self, instructions: List[int]) -> int:
        MOD = 10**9 + 7
        max_val = max(instructions)
        bit = [0] * (max_val + 1)

        def update(index, value):
            while index <= max_val:
                bit[index] += value
                index += index & -index

        def query(index):
            sum = 0
            while index > 0:
                sum += bit[index]
                index -= index & -index
            return sum

        total_cost = 0
        for i, x in enumerate(instructions):
            left_cost = query(x - 1)
            right_cost = i - query(x)
            total_cost = (total_cost + min(left_cost, right_cost)) % MOD
            update(x, 1)

        return total_cost