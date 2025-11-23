class Solution:
    def pathInZigZagTree(self, label: int) -> list[int]:
        level = 1
        while 2**level <= label:
            level += 1

        path = [0] * level
        path[-1] = label

        for i in range(level - 2, -1, -1):
            opposite = (2**(i+1) - 1) - (label // 2) + 2**i
            path[i] = opposite
            label = opposite

        return path