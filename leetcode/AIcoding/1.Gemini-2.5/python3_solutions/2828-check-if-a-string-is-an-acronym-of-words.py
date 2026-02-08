class Solution:
    def isAcronym(self, words: list[str], s: str) -> bool:
        if len(s) != len(words):
            return False

        for i in range(len(words)):
            if words[i][0] != s[i]:
                return False

        return True