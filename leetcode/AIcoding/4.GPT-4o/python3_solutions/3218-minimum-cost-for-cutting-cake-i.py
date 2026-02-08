class Solution:
    def minCost(self, h: int, w: int, horizontalCuts: List[int], verticalCuts: List[int]) -> int:
        horizontalCuts.sort()
        verticalCuts.sort()

        horizontalCuts = [0] + horizontalCuts + [h]
        verticalCuts = [0] + verticalCuts + [w]

        maxH = max(horizontalCuts[i] - horizontalCuts[i - 1] for i in range(1, len(horizontalCuts)))
        maxW = max(verticalCuts[i] - verticalCuts[i - 1] for i in range(1, len(verticalCuts)))

        return (maxH * maxW) % (10**9 + 7)