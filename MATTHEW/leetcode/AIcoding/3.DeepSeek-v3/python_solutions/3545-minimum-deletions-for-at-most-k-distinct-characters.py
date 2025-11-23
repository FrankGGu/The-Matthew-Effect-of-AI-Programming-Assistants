class Solution:
    def minimumDeletions(self, s: str, k: int) -> int:
        from collections import defaultdict

        freq = defaultdict(int)
        for char in s:
            freq[char] += 1

        counts = sorted(freq.values(), reverse=True)
        res = 0

        for i in range(len(counts)):
            if counts[i] > counts[0] - k:
                res += counts[i] - (counts[0] - k)

        return res