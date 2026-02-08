class Solution:
    def numSplits(self, s: str) -> int:
        left_counts = {}
        right_counts = {}

        for ch in s:
            right_counts[ch] = right_counts.get(ch, 0) + 1

        res = 0
        for ch in s:
            left_counts[ch] = left_counts.get(ch, 0) + 1
            right_counts[ch] -= 1
            if right_counts[ch] == 0:
                del right_counts[ch]
            if len(left_counts) == len(right_counts):
                res += 1
        return res