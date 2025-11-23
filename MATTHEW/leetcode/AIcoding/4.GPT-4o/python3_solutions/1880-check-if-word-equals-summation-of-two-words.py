class Solution:
    def isSumEqual(self, firstWord: str, secondWord: str, targetWord: str) -> bool:
        def word_to_number(word: str) -> int:
            return int(''.join(str(ord(c) - ord('a')) for c in word))

        return word_to_number(firstWord) + word_to_number(secondWord) == word_to_number(targetWord)