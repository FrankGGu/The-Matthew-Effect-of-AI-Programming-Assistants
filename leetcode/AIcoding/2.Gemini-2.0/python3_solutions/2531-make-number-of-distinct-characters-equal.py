from collections import Counter

class Solution:
    def isItPossible(self, word1: str, word2: str) -> bool:
        c1 = Counter(word1)
        c2 = Counter(word2)

        for char1 in set(word1):
            for char2 in set(word2):
                temp_c1 = c1.copy()
                temp_c2 = c2.copy()

                temp_c1[char1] -= 1
                if temp_c1[char1] == 0:
                    del temp_c1[char1]

                if char2 in temp_c1:
                    temp_c1[char2] += 1
                else:
                    temp_c1[char2] = 1

                temp_c2[char2] -= 1
                if temp_c2[char2] == 0:
                    del temp_c2[char2]

                if char1 in temp_c2:
                    temp_c2[char1] += 1
                else:
                    temp_c2[char1] = 1

                if len(temp_c1) == len(temp_c2):
                    return True

        return False