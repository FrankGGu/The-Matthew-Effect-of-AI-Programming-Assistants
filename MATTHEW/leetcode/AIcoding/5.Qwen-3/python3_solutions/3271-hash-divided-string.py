class Solution:
    def splitString(self, s: str) -> bool:
        def backtrack(index, prev, count):
            if index == len(s):
                return count >= 2
            for i in range(index + 1, len(s) + 1):
                num = int(s[index:i])
                if prev == -1 or num == prev:
                    if backtrack(i, num, count + 1):
                        return True
            return False

        return backtrack(0, -1, 0)