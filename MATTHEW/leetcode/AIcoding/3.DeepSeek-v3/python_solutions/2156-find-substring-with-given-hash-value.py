class Solution:
    def subStrHash(self, s: str, power: int, modulo: int, k: int, hashValue: int) -> str:
        n = len(s)
        current_hash = 0
        power_k = pow(power, k, modulo)

        for i in range(n - 1, n - k - 1, -1):
            current_hash = (current_hash * power + (ord(s[i]) - ord('a') + 1)) % modulo

        res = -1
        if current_hash == hashValue:
            res = n - k

        for i in range(n - k - 1, -1, -1):
            current_hash = (current_hash * power + (ord(s[i]) - ord('a') + 1) - (ord(s[i + k]) - ord('a') + 1) * power_k) % modulo
            if current_hash == hashValue:
                res = i

        return s[res:res + k]