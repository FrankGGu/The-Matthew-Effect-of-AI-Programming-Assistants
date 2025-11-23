class Solution:
    def subStrHash(self, s: str, power: int, modulo: int, k: int, hashValue: int) -> str:
        n = len(s)
        curr_hash = 0
        for i in range(k):
            curr_hash = (curr_hash * power + (ord(s[i]) - ord('a') + 1)) % modulo

        if curr_hash == hashValue:
            return s[:k]

        power_k = pow(power, k, modulo)
        for i in range(k, n):
            curr_hash = (curr_hash * power - (ord(s[i - k]) - ord('a') + 1) * power_k + (ord(s[i]) - ord('a') + 1)) % modulo
            if curr_hash < 0:
                curr_hash += modulo
            if curr_hash == hashValue:
                return s[i - k + 1:i + 1]

        return ""