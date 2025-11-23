class Solution:
    def closeStrings(self, word1: str, word2: str) -> bool:
        if len(word1) != len(word2):
            return False
        count1 = {}
        count2 = {}
        for c in word1:
            count1[c] = count1.get(c, 0) + 1
        for c in word2:
            count2[c] = count2.get(c, 0) + 1
        if count1.keys() != count2.keys():
            return False
        return sorted(count1.values()) == sorted(count2.values())