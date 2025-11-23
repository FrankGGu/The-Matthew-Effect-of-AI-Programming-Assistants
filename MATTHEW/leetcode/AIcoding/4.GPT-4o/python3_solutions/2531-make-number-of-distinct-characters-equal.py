class Solution:
    def isItPossible(self, word1: str, word2: str) -> bool:
        from collections import Counter

        count1 = Counter(word1)
        count2 = Counter(word2)

        distinct1 = len(count1)
        distinct2 = len(count2)

        for i in range(26):
            c = chr(ord('a') + i)
            num1 = count1[c]
            num2 = count2[c]
            if num1 > 0 and num2 > 0:
                if distinct1 == distinct2:
                    return True
            elif num1 > 0:
                if distinct1 - 1 == distinct2:
                    return True
            elif num2 > 0:
                if distinct1 == distinct2 - 1:
                    return True

        return distinct1 == distinct2