from collections import Counter

class Solution:
    def checkAlmostEquivalent(self, word1: str, word2: str) -> bool:
        freq1 = Counter(word1)
        freq2 = Counter(word2)

        for char_code in range(ord('a'), ord('z') + 1):
            char = chr(char_code)
            count1 = freq1.get(char, 0)
            count2 = freq2.get(char, 0)
            if abs(count1 - count2) > 3:
                return False

        return True