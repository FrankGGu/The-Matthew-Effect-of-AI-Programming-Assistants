class Solution:
    def minTaps(self, n: int, ranges: List[int]) -> int:
        max_range = [0] * (n + 1)
        for i, r in enumerate(ranges):
            start = max(0, i - r)
            end = min(n, i + r)
            max_range[start] = max(max_range[start], end)

        taps = 0
        curr_range = 0
        next_range = 0
        for i in range(n):
            next_range = max(next_range, max_range[i])
            if i == curr_range:
                taps += 1
                curr_range = next_range
                if i == curr_range:
                    return -1

        return taps