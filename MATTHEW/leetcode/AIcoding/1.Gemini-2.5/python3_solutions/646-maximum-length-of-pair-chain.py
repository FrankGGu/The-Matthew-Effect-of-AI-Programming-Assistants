import math

class Solution:
    def findLongestChain(self, pairs: list[list[int]]) -> int:
        if not pairs:
            return 0

        pairs.sort(key=lambda x: x[1])

        chain_length = 0
        prev_end = float('-inf')

        for start, end in pairs:
            if start > prev_end:
                chain_length += 1
                prev_end = end

        return chain_length