class Solution:
    def maxArea(self, h: int, w: int, horizontalCuts: list[int], verticalCuts: list[int]) -> int:
        horizontalCuts.sort()
        verticalCuts.sort()
        max_h_diff = max(horizontalCuts[0], h - horizontalCuts[-1])
        for i in range(1, len(horizontalCuts)):
            max_h_diff = max(max_h_diff, horizontalCuts[i] - horizontalCuts[i - 1])

        max_v_diff = max(verticalCuts[0], w - verticalCuts[-1])
        for i in range(1, len(verticalCuts)):
            max_v_diff = max(max_v_diff, verticalCuts[i] - verticalCuts[i - 1])

        return (max_h_diff * max_v_diff) % (10**9 + 7)