class Solution:
    def makeStringsEqual(self, s: str, target: str) -> bool:
        return s == target or (set(s) == set(target) == {'0', '1'})