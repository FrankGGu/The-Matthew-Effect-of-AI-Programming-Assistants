class Solution:
    def minCost(self, height: int, width: int, horizontalCuts: List[int], verticalCuts: List[int]) -> int:
        horizontalCuts.sort()
        verticalCuts.sort()

        h_diffs = [horizontalCuts[0]] + [horizontalCuts[i] - horizontalCuts[i - 1] for i in range(1, len(horizontalCuts))] + [height - horizontalCuts[-1]]
        v_diffs = [verticalCuts[0]] + [verticalCuts[i] - verticalCuts[i - 1] for i in range(1, len(verticalCuts))] + [width - verticalCuts[-1]]

        h_max = max(h_diffs)
        v_max = max(v_diffs)

        return (h_max * v_max) % (10**9 + 7)