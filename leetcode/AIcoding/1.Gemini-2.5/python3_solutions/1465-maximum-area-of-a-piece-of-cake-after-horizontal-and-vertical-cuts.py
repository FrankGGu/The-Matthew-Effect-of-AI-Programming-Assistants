class Solution:
    def maxArea(self, h: int, w: int, horizontalCuts: list[int], verticalCuts: list[int]) -> int:
        MOD = 10**9 + 7

        def get_max_diff(limit: int, cuts: list[int]) -> int:
            all_cuts = sorted([0] + cuts + [limit])

            max_d = 0
            for i in range(1, len(all_cuts)):
                max_d = max(max_d, all_cuts[i] - all_cuts[i-1])
            return max_d

        max_h_diff = get_max_diff(h, horizontalCuts)
        max_w_diff = get_max_diff(w, verticalCuts)

        return (max_h_diff * max_w_diff) % MOD