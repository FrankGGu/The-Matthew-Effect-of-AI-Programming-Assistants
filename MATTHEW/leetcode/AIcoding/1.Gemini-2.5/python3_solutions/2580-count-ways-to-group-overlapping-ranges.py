class Solution:
    def countWays(self, ranges: list[list[int]]) -> int:
        ranges.sort()

        MOD = 10**9 + 7

        num_disjoint_intervals = 0

        current_end = -1

        for start, end in ranges:
            if start > current_end:
                num_disjoint_intervals += 1
                current_end = end
            else:
                current_end = max(current_end, end)

        return pow(2, num_disjoint_intervals, MOD)