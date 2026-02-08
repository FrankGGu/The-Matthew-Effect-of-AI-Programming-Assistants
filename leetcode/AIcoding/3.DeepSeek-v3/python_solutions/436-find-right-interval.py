class Solution:
    def findRightInterval(self, intervals: List[List[int]]) -> List[int]:
        starts = []
        start_to_index = {}
        for i, interval in enumerate(intervals):
            start = interval[0]
            starts.append(start)
            start_to_index[start] = i

        starts_sorted = sorted(starts)
        res = []

        for interval in intervals:
            end = interval[1]
            left, right = 0, len(starts_sorted)
            while left < right:
                mid = (left + right) // 2
                if starts_sorted[mid] < end:
                    left = mid + 1
                else:
                    right = mid
            if left < len(starts_sorted):
                res.append(start_to_index[starts_sorted[left]])
            else:
                res.append(-1)

        return res