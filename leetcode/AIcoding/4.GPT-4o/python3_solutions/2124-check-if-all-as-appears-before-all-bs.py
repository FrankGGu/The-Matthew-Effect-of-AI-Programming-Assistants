class Solution:
    def checkString(self, s: str) -> bool:
        return s.index('b') >= s.index('a') if 'a' in s and 'b' in s else True