class Solution:
    def countIntegers(self, intervals: List[List[int]]) -> int:
        intervals.sort()
        count = 0
        for start, end in intervals:
            count += end - start + 1
        return count