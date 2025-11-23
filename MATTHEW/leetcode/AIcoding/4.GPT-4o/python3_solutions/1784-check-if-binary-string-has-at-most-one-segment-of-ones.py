class Solution:
    def checkOnesSegment(self, s: str) -> bool:
        return s.count('1') == s.count('1.') + 1