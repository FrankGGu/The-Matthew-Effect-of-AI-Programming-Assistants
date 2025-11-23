from collections import Counter

class Solution:
    def countWords(self, words1: list[str], words2: list[str]) -> int:
        count1 = Counter(words1)
        count2 = Counter(words2)

        ans = 0
        for word in count1:
            if count1[word] == 1 and word in count2 and count2[word] == 1:
                ans += 1

        return ans