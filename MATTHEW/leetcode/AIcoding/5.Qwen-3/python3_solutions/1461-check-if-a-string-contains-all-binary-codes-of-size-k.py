class Solution:
    def hasAllCodes(self, s: str, k: int) -> bool:
        seen = set()
        for i in range(len(s) - k + 1):
            substring = s[i:i+k]
            seen.add(substring)
            if len(seen) == (1 << k):
                return True
        return False