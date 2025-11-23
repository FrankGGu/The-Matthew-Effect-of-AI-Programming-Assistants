class Solution:
    def reversePrefix(self, word: str, ch: str) -> str:
        idx = -1
        for i in range(len(word)):
            if word[i] == ch:
                idx = i
                break

        if idx == -1:
            return word

        prefix = word[:idx+1]
        suffix = word[idx+1:]

        reversed_prefix = prefix[::-1]

        return reversed_prefix + suffix