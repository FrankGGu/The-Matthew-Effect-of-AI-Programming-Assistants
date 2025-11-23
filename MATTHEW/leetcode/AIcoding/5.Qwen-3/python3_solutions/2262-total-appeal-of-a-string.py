class Solution:
    def appealSum(self, s: str) -> int:
        last = {}
        total = 0
        for i, c in enumerate(s):
            if c in last:
                total += (i - last[c]) * (len(s) - i)
            else:
                total += (i + 1) * (len(s) - i)
            last[c] = i
        return total