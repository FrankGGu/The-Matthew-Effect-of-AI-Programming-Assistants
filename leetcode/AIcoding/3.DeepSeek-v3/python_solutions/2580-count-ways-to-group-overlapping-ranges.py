class Solution:
    def countWays(self, ranges: List[List[int]]) -> int:
        ranges.sort()
        merged = []
        for start, end in ranges:
            if not merged or start > merged[-1][1]:
                merged.append([start, end])
            else:
                merged[-1][1] = max(merged[-1][1], end)
        return pow(2, len(merged), 10**9 + 7)