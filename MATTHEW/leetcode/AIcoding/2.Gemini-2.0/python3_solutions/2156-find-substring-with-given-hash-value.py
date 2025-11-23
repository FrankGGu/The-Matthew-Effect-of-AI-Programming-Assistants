class Solution:
    def subStrHash(self, s: str, power: int, modulo: int, k: int, hashValue: int) -> str:
        n = len(s)
        ans = ""
        curr_hash = 0
        p_pow = 1
        for _ in range(k - 1):
            p_pow = (p_pow * power) % modulo

        for i in range(n - 1, n - k - 1, -1):
            curr_hash = (curr_hash * power + (ord(s[i]) - ord('a') + 1)) % modulo

        if curr_hash == hashValue:
            ans = s[n - k:]

        for i in range(n - k - 1, -1, -1):
            curr_hash = (curr_hash - (ord(s[i + k]) - ord('a') + 1) * p_pow) % modulo
            if curr_hash < 0:
                curr_hash += modulo
            curr_hash = (curr_hash * power + (ord(s[i]) - ord('a') + 1)) % modulo
            if curr_hash == hashValue:
                ans = s[i:i + k]

        return ans