import bisect

class Solution:
    def fullBloomFlowers(self, flowers: List[List[int]], people: List[int]]) -> List[int]:
        starts = []
        ends = []
        for start, end in flowers:
            starts.append(start)
            ends.append(end + 1)

        starts.sort()
        ends.sort()

        res = []
        for person in people:
            i = bisect.bisect_right(starts, person)
            j = bisect.bisect_right(ends, person)
            res.append(i - j)

        return res