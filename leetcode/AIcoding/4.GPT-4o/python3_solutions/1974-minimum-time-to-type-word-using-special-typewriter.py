class Solution:
    def minTimeToType(self, word: str) -> int:
        time = len(word) + 1
        for i in range(1, len(word)):
            time += min(abs(ord(word[i]) - ord(word[i - 1])), 26 - abs(ord(word[i]) - ord(word[i - 1])))
        return time