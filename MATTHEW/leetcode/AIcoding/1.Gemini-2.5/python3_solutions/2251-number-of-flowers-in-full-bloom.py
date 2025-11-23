import bisect

class Solution:
    def fullBloomFlowers(self, flowers: list[list[int]], people: list[int]) -> list[int]:
        starts = []
        ends = []
        for s, e in flowers:
            starts.append(s)
            ends.append(e)

        starts.sort()
        ends.sort()

        results = []
        for p_time in people:
            started_count = bisect.bisect_right(starts, p_time)
            ended_count = bisect.bisect_left(ends, p_time)

            results.append(started_count - ended_count)

        return results