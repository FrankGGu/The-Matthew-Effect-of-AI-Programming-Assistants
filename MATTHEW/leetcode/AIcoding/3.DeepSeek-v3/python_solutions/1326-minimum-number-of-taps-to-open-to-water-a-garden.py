class Solution:
    def minTaps(self, n: int, ranges: List[int]) -> int:
        intervals = []
        for i, r in enumerate(ranges):
            start = max(0, i - r)
            end = min(n, i + r)
            intervals.append((start, end))

        intervals.sort()
        res = 0
        current_end = 0
        i = 0
        while current_end < n:
            max_end = current_end
            while i < len(intervals) and intervals[i][0] <= current_end:
                max_end = max(max_end, intervals[i][1])
                i += 1
            if max_end == current_end:
                return -1
            current_end = max_end
            res += 1

        return res