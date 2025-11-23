class Solution:
    def appealSum(self, s: str) -> int:
        last = {}
        res = 0
        total = 0
        for i, char in enumerate(s):
            total += i - last.get(char, -1)
            res += total
            last[char] = i
        return res