class Solution:
    def maxNumberOfStringPairs(self, words: list[str]) -> int:
        count = 0
        n = len(words)
        for i in range(n):
            for j in range(i + 1, n):
                if words[i] == words[j][::-1]:
                    count += 1
        return count