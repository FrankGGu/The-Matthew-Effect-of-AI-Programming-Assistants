class Solution:
    def minSeconds(self, s: str) -> int:
        from collections import defaultdict

        pos = defaultdict(list)
        for i, c in enumerate(s):
            pos[c].append(i)

        max_gap = 0
        for c in pos:
            indices = pos[c]
            n = len(indices)
            for i in range(n):
                prev = indices[i - 1] if i > 0 else indices[-1] + len(s)
                curr = indices[i]
                gap = curr - prev
                max_gap = max(max_gap, gap)

        return max_gap - 1