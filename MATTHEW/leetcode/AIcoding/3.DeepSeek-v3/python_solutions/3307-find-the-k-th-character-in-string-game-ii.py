class Solution:
    def findKthCharacter(self, s: str, k: int) -> str:
        n = len(s)
        while k > n:
            m = 1
            while m * 2 <= k:
                m *= 2
            k -= m
            if k == 0:
                k = m // 2
        return s[k - 1]