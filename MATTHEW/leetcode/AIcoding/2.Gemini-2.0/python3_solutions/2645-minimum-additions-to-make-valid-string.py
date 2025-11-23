class Solution:
    def addMinimum(self, word: str) -> int:
        ans = 0
        i = 0
        while i < len(word):
            if i < len(word) and word[i] == 'a':
                i += 1
            else:
                ans += 1
            if i < len(word) and word[i] == 'b':
                i += 1
            else:
                ans += 1
            if i < len(word) and word[i] == 'c':
                i += 1
            else:
                ans += 1
        return ans