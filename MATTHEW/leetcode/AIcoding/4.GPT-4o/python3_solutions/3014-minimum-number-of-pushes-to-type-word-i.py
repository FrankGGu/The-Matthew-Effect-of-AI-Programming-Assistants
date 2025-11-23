class Solution:
    def minimumPushes(self, word1: str, word2: str) -> int:
        from collections import defaultdict

        count1 = defaultdict(int)
        count2 = defaultdict(int)

        for char in word1:
            count1[char] += 1

        for char in word2:
            count2[char] += 1

        pushes = 0

        for char in set(count1.keys()).union(set(count2.keys())):
            pushes += abs(count1[char] - count2[char])

        return pushes // 2