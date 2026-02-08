class Solution:
    def countWays(self, ranges: List[List[int]]) -> int:
        ranges.sort()
        merged = []
        for interval in ranges:
            if not merged or interval[0] > merged[-1][1]:
                merged.append(interval)
            else:
                merged[-1][1] = max(merged[-1][1], interval[1])

        return pow(2, len(merged), 10**9 + 7)