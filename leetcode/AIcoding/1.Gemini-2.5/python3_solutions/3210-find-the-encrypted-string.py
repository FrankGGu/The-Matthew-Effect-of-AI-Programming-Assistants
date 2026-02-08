class Solution:
    def findTheEncryptedString(self, s: str, k: int) -> str:
        n = len(s)
        k_eff = k % n
        return s[k_eff:] + s[:k_eff]