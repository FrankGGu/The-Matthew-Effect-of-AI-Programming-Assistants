class Solution:
    def minOperations(self, s: str) -> int:
        freq = {}
        for c in s:
            freq[c] = freq.get(c, 0) + 1

        values = sorted(freq.values())
        res = 0
        for i in range(1, len(values)):
            if values[i] <= values[i-1]:
                target = values[i-1] + 1
                res += target - values[i]
                values[i] = target
        return res