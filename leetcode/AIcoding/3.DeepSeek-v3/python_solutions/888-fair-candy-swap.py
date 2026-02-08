class Solution:
    def fairCandySwap(self, aliceSizes: List[int], bobSizes: List[int]) -> List[int]:
        sumA = sum(aliceSizes)
        sumB = sum(bobSizes)
        setB = set(bobSizes)
        target = (sumA + sumB) // 2
        for a in aliceSizes:
            b = target - (sumA - a)
            if b in setB:
                return [a, b]
        return []