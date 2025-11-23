class Solution:
    def countTheHiddenSequences(self, m: List[int]) -> int:
        n = len(m)
        res = 1
        for i in range(n):
            if m[i] == 0:
                res *= 1
            else:
                res *= 2
        return res