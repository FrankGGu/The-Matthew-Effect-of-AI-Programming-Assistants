class Interval:
    def __init__(self, s=0, e=0):
        self.start = s
        self.end = e

class Solution:
    def insert(self, intervals, newInterval):
        i = 0
        n = len(intervals)
        result = []

        while i < n and intervals[i].end < newInterval.start:
            result.append(intervals[i])
            i += 1

        while i < n and intervals[i].start <= newInterval.end:
            newInterval.start = min(newInterval.start, intervals[i].start)
            newInterval.end = max(newInterval.end, intervals[i].end)
            i += 1

        result.append(newInterval)

        while i < n:
            result.append(intervals[i])
            i += 1

        return result