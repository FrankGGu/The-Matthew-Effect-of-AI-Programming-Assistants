class Solution:
    def fairCandySwap(self, aliceSizes: list[int], bobSizes: list[int]) -> list[int]:
        sum_a = sum(aliceSizes)
        sum_b = sum(bobSizes)

        diff = (sum_a - sum_b) // 2

        bob_set = set(bobSizes)

        for x in aliceSizes:
            y = x - diff
            if y in bob_set:
                return [x, y]

        return [] # Should not be reached based on problem constraints