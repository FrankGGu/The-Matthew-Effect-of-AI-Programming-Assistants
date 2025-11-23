class Solution:
    def findLongestWord(self, s: str, d: List[str]) -> str:
        d.sort()
        max_len = 0
        result = ""
        for word in d:
            i = 0
            j = 0
            while i < len(s) and j < len(word):
                if s[i] == word[j]:
                    j += 1
                i += 1
            if j == len(word):
                if len(word) > max_len:
                    max_len = len(word)
                    result = word
                elif len(word) == max_len and word < result:
                    result = word
        return result