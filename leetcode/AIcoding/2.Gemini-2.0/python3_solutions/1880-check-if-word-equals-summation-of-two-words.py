class Solution:
    def isSumEqual(self, firstWord: str, secondWord: str, targetWord: str) -> bool:
        def convert(word):
            num = 0
            for char in word:
                num = num * 10 + (ord(char) - ord('a'))
            return num

        return convert(firstWord) + convert(secondWord) == convert(targetWord)