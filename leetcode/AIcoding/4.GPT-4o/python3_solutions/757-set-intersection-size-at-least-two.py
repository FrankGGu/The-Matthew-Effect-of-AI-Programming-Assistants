class Solution:
    def intersectionSizeTwo(self, intervals: List[List[int]]) -> int:
        intervals.sort(key=lambda x: (x[0], x[1]))
        count = 0
        end = []

        for s, e in intervals:
            if len(end) < 2 or end[-1] < s:
                count += 2
                end = [e - 1, e]
            elif end[-1] == s:
                count += 1
                end[-1] = e
            elif end[-2] < s:
                count += 1
                end[-1] = e

        return count