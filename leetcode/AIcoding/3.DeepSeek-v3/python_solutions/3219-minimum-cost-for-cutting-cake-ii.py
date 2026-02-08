import heapq

class Solution:
    def minCost(self, n: int, m: int, horizontalCuts: List[int], verticalCuts: List[int]) -> int:
        horizontalCuts.sort()
        verticalCuts.sort()

        max_h = max(horizontalCuts[0], n - horizontalCuts[-1])
        for i in range(1, len(horizontalCuts)):
            max_h = max(max_h, horizontalCuts[i] - horizontalCuts[i-1])

        max_v = max(verticalCuts[0], m - verticalCuts[-1])
        for i in range(1, len(verticalCuts)):
            max_v = max(max_v, verticalCuts[i] - verticalCuts[i-1])

        return (max_h * max_v) % (10**9 + 7)