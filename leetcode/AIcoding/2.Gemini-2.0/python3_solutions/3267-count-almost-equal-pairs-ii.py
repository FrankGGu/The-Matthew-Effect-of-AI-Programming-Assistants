from collections import defaultdict

class Solution:
    def countAlmostEqualPairs(self, words1: list[str], words2: list[str]) -> int:
        n = len(words1)
        count = 0

        def diff(s1, s2):
            diff_count = 0
            for i in range(len(s1)):
                if s1[i] != s2[i]:
                    diff_count += 1
            return diff_count

        for i in range(n):
            for j in range(i + 1, n):
                if len(words1[i]) == len(words2[j]):
                    if diff(words1[i], words2[j]) <= 2:
                        count += 1

        return count