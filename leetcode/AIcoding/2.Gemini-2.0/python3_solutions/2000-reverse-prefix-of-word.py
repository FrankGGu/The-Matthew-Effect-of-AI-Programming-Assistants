class Solution:
    def reversePrefix(self, word: str, ch: str) -> str:
        index = word.find(ch)
        if index == -1:
            return word
        else:
            prefix = word[:index+1]
            suffix = word[index+1:]
            return prefix[::-1] + suffix