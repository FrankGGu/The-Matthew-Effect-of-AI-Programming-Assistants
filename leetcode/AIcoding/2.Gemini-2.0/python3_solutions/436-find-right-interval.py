from typing import List

class Solution:
    def findRightInterval(self, intervals: List[List[int]]) -> List[int]:
        n = len(intervals)
        starts = sorted((intervals[i][0], i) for i in range(n))
        result = []
        for i in range(n):
            end = intervals[i][1]
            l, r = 0, n - 1
            right_index = -1
            while l <= r:
                mid = (l + r) // 2
                if starts[mid][0] >= end:
                    right_index = starts[mid][1]
                    r = mid - 1
                else:
                    l = mid + 1
            result.append(right_index)
        return result