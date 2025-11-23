from collections import Counter
from typing import List

class Solution:
    def wordSubsets(self, words1: List[str], words2: List[str]) -> List[str]:
        def count(c):
            return Counter(c)

        max_count = {}
        for word in words2:
            temp = count(word)
            for char in temp:
                if temp[char] > max_count.get(char, 0):
                    max_count[char] = temp[char]

        result = []
        for word in words1:
            word_count = count(word)
            subset = True
            for char in max_count:
                if word_count.get(char, 0) < max_count[char]:
                    subset = False
                    break
            if subset:
                result.append(word)

        return result