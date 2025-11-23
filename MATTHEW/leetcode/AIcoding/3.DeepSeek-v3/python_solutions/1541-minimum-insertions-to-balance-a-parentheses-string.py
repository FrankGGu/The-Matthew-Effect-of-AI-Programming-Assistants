class Solution:
    def minInsertions(self, s: str) -> int:
        res = 0
        need = 0

        for c in s:
            if c == '(':
                need += 2
                if need % 2 == 1:
                    res += 1
                    need -= 1
            else:
                need -= 1
                if need < 0:
                    res += 1
                    need += 2

        return res + need