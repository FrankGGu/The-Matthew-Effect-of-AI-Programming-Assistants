class Solution:
    def intersectionSizeFirst(self, intervals):
        intervals.sort(key=lambda x: (x[1], x[0]))
        res = 0
        last = -1
        second_last = -1
        for s, e in intervals:
            if s > second_last:
                res += 2
                last = e
                second_last = e - 1
            elif s > last:
                res += 1
                second_last = last
                last = e
        return res