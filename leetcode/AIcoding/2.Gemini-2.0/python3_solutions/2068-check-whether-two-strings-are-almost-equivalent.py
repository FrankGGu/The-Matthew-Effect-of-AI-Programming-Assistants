class Solution:
    def checkAlmostEquivalent(self, word1: str, word2: str) -> bool:
        count1 = {}
        count2 = {}

        for char in word1:
            count1[char] = count1.get(char, 0) + 1
        for char in word2:
            count2[char] = count2.get(char, 0) + 1

        for char in set(list(count1.keys()) + list(count2.keys())):
            diff = abs(count1.get(char, 0) - count2.get(char, 0))
            if diff > 3:
                return False

        return True