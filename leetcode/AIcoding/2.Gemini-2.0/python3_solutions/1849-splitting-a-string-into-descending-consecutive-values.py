class Solution:
    def splitString(self, s: str) -> bool:
        def backtrack(index, prev):
            if index == len(s):
                return True

            for i in range(index, len(s)):
                curr = int(s[index:i+1])
                if prev is None or curr == prev - 1:
                    if backtrack(i+1, curr):
                        return True
            return False

        for i in range(len(s) - 1):
            first = int(s[:i+1])
            if backtrack(i+1, first):
                return True
        return False