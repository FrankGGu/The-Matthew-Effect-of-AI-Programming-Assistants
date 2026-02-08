class Solution:
    def minTaps(self, n: int, ranges: List[int]) -> int:
        max_range = [0] * (n + 1)
        for i in range(n + 1):
            left = max(0, i - ranges[i])
            right = min(n, i + ranges[i])
            max_range[left] = max(max_range[left], right)

        taps, end, farthest = 0, 0, 0
        for i in range(n):
            farthest = max(farthest, max_range[i])
            if i == end:
                taps += 1
                end = farthest
                if end >= n:
                    return taps
        return -1