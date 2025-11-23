class Solution:
    def makeStringsEqual(self, s: str, target: str) -> bool:
        if s == target:
            return True

        has_one_s = '1' in s
        has_one_t = '1' in target

        if has_one_s and has_one_t:
            return True
        else:
            return False