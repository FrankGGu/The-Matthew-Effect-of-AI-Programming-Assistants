class Solution:
    def repeatedStringMatch(self, a: str, b: str) -> int:
        if not b:
            return 0
        max_repeat = (len(b) // len(a)) + 2
        for i in range(1, max_repeat + 1):
            if b in a * i:
                return i
        return -1