class Solution:
    def detectCapitalUse(self, word: str) -> bool:
        n = len(word)
        if n == 1:
            return True

        if word[0].isupper() and word[1].isupper():
            for i in range(2, n):
                if word[i].islower():
                    return False
            return True
        elif word[0].isupper() and word[1].islower():
            for i in range(2, n):
                if word[i].isupper():
                    return False
            return True
        else:
            for i in range(1, n):
                if word[i].isupper():
                    return False
            return True