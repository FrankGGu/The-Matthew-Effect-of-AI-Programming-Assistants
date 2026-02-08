class Solution:
    def splitString(self, s: str) -> bool:
        n = len(s)

        def backtrack(index, prev):
            if index == n:
                return True
            for j in range(index, n):
                curr = int(s[index:j+1])
                if prev == float('inf') or curr == prev - 1:
                    if backtrack(j + 1, curr):
                        return True
            return False

        return backtrack(0, float('inf'))