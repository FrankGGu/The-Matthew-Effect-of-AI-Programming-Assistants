class Solution:
    def createSortedArray(self, instructions: List[int]) -> int:
        MOD = 10**9 + 7
        max_num = max(instructions)
        count = [0] * (max_num + 1)
        res = 0

        def update(index, value):
            while index < len(count):
                count[index] += value
                index += index & -index

        def query(index):
            total = 0
            while index > 0:
                total += count[index]
                index -= index & -index
            return total

        for num in instructions:
            left = query(num - 1)
            right = query(max_num) - query(num)
            res = (res + min(left, right)) % MOD
            update(num, 1)

        return res