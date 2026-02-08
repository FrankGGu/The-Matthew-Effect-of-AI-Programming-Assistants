from itertools import groupby

class Solution:
    def checkOnesSegment(self, s: str) -> bool:
        ones_segments = 0
        zeros_segments = 0

        for char, _ in groupby(s):
            if char == '1':
                ones_segments += 1
            else:
                zeros_segments += 1

        return ones_segments > zeros_segments