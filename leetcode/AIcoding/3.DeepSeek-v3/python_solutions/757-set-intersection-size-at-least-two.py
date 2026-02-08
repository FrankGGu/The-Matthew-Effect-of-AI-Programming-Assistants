class Solution:
    def intersectionSizeTwo(self, intervals: List[List[int]]) -> int:
        intervals.sort(key=lambda x: (x[1], -x[0]))
        res = []
        for start, end in intervals:
            if not res or res[-1] < start:
                res.append(end - 1)
                res.append(end)
            elif res[-2] < start:
                if res[-1] == end:
                    res.append(end - 1)
                else:
                    res.append(end)
        return len(res)