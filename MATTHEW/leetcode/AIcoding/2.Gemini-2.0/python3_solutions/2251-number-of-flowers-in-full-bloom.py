import bisect

class Solution:
    def fullBloomFlowers(self, flowers: list[list[int]], people: list[int]) -> list[int]:
        starts = sorted([flower[0] for flower in flowers])
        ends = sorted([flower[1] for flower in flowers])

        result = []
        for person in people:
            started = bisect.bisect_right(starts, person)
            ended = bisect.bisect_left(ends, person)
            result.append(started - ended)

        return result