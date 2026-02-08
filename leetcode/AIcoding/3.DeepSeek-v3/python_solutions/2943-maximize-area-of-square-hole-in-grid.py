class Solution:
    def maximizeSquareHoleArea(self, n: int, m: int, hBars: List[int], vBars: List[int]) -> int:
        def get_max_consecutive(bars):
            if not bars:
                return 0
            bars_sorted = sorted(bars)
            max_len = 1
            current_len = 1
            for i in range(1, len(bars_sorted)):
                if bars_sorted[i] == bars_sorted[i-1] + 1:
                    current_len += 1
                    max_len = max(max_len, current_len)
                else:
                    current_len = 1
            return max_len + 1

        h_max = get_max_consecutive(hBars)
        v_max = get_max_consecutive(vBars)
        min_side = min(h_max, v_max)
        return min_side * min_side