class Solution:
    def isItPossible(self, word1: str, word2: str) -> bool:
        from collections import defaultdict

        count1 = defaultdict(int)
        count2 = defaultdict(int)

        for c in word1:
            count1[c] += 1
        for c in word2:
            count2[c] += 1

        keys1 = list(count1.keys())
        keys2 = list(count2.keys())

        for c1 in keys1:
            for c2 in keys2:
                temp1 = defaultdict(int, count1)
                temp2 = defaultdict(int, count2)

                temp1[c1] -= 1
                if temp1[c1] == 0:
                    del temp1[c1]
                temp1[c2] += 1

                temp2[c2] -= 1
                if temp2[c2] == 0:
                    del temp2[c2]
                temp2[c1] += 1

                if len(temp1) == len(temp2):
                    return True
        return False