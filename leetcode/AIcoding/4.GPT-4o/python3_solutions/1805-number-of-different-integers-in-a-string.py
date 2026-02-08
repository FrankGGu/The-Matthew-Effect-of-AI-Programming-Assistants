class Solution:
    def numDifferentIntegers(self, word: str) -> int:
        import re
        return len(set(re.findall(r'\d+', word)))