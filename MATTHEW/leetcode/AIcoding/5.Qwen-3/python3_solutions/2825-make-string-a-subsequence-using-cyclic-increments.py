class Solution:
    def canMakeASubsequence(self, source: str, target: str) -> bool:
        def isPossible(c1, c2):
            if c1 == c2:
                return True
            return (ord(c2) - ord(c1)) % 26 == 1

        i = j = 0
        while i < len(source) and j < len(target):
            if isPossible(source[i], target[j]):
                j += 1
            i += 1
        return j == len(target)