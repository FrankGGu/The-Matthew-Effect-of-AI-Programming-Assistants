class Solution:
    def findAlmostEqual(self, s: str, t: str) -> int:
        len_t = len(t)
        len_s = len(s)
        if len_s < len_t:
            return -1

        for i in range(len_s - len_t + 1):
            substring = s[i:i+len_t]
            mismatch = 0
            for a, b in zip(substring, t):
                if a != b:
                    mismatch += 1
                    if mismatch > 1:
                        break
            if mismatch <= 1:
                return i
        return -1