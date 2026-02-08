class Solution:
    def maxArea(self, h: int, w: int, horizontal: List[int], vertical: List[int]) -> int:
        horizontal.sort()
        vertical.sort()

        max_h = max(horizontal[0], h - horizontal[-1])
        for i in range(1, len(horizontal)):
            max_h = max(max_h, horizontal[i] - horizontal[i - 1])

        max_w = max(vertical[0], w - vertical[-1])
        for i in range(1, len(vertical)):
            max_w = max(max_w, vertical[i] - vertical[i - 1])

        return max_h * max_w