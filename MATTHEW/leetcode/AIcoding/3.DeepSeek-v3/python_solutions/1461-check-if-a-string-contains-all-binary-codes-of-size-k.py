class Solution:
    def hasAllCodes(self, s: str, k: int) -> bool:
        need = 1 << k
        got = set()

        for i in range(len(s) - k + 1):
            substring = s[i:i+k]
            if substring not in got:
                got.add(substring)
                need -= 1
                if need == 0:
                    return True
        return False