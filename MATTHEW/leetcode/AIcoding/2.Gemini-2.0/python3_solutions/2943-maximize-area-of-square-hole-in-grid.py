class Solution:
    def maximizeSquareHoleArea(self, n: int, m: int, hBars: list[int], vBars: list[int]) -> int:
        hBars.sort()
        vBars.sort()

        def max_consecutive(bars):
            max_len = 1
            curr_len = 1
            for i in range(1, len(bars)):
                if bars[i] == bars[i - 1] + 1:
                    curr_len += 1
                else:
                    max_len = max(max_len, curr_len)
                    curr_len = 1
            max_len = max(max_len, curr_len)
            return max_len + 1

        horizontal_len = max_consecutive(hBars)
        vertical_len = max_consecutive(vBars)

        return min(horizontal_len, vertical_len) ** 2