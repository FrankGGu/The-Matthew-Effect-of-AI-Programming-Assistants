class Solution:
    def maxScore(self, intervals: List[List[int]]) -> int:
        intervals.sort(key=lambda x: x[1])
        prev_end = -float('inf')
        score = 0

        for start, end, val in intervals:
            if start >= prev_end:
                score += val
                prev_end = end

        return score