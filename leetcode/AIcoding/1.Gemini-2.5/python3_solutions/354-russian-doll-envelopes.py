import bisect

class Solution:
    def maxEnvelopes(self, envelopes: list[list[int]]) -> int:
        envelopes.sort(key=lambda x: (x[0], -x[1]))

        tails = []
        for _, height in envelopes:
            idx = bisect.bisect_left(tails, height)
            if idx == len(tails):
                tails.append(height)
            else:
                tails[idx] = height

        return len(tails)