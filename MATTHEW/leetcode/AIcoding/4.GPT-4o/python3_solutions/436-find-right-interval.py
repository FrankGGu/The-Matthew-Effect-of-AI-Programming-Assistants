class Solution:
    def findRightInterval(self, intervals: List[List[int]]) -> List[int]:
        indexed_intervals = sorted((start, i) for i, (start, end) in enumerate(intervals))
        result = []

        for start, end in intervals:
            left, right = 0, len(indexed_intervals)
            while left < right:
                mid = (left + right) // 2
                if indexed_intervals[mid][0] < end:
                    left = mid + 1
                else:
                    right = mid
            result.append(indexed_intervals[left][1] if left < len(indexed_intervals) else -1)

        return result