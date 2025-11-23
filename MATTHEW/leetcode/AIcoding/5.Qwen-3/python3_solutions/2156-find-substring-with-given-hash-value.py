class Solution:
    def findSubstring(self, s: str, power: int, modulo: int, k: int, hashValue: int) -> str:
        n = len(s)
        base = 26
        hash_val = 0
        for i in range(k):
            hash_val = (hash_val * base + ord(s[i])) % modulo
        if hash_val == hashValue:
            return s[:k]
        power_k = pow(base, k, modulo)
        for i in range(k, n):
            hash_val = (hash_val - ord(s[i - k]) * power_k) % modulo
            hash_val = (hash_val * base + ord(s[i])) % modulo
            if hash_val == hashValue:
                return s[i - k + 1:i + 1]
        return ""